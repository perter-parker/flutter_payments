library tosspayments_sdk_flutter;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payments/tosspayments_sdk/model/paymentData.dart';
import 'package:flutter_payments/tosspayments_sdk/model/tosspaement_result.dart';
import 'package:flutter_payments/tosspayments_sdk/widget/payment_widget_webview.dart';
import 'package:tosspayments_webview_flutter/tosspayments_webview_flutter.dart';

class TossPaymentsWidget extends StatelessWidget {
  final String clientKey;
  final PaymentData data;
  final success;
  final fail;

  const TossPaymentsWidget(
      {Key? key, required this.clientKey, required this.data, required this.success, required this.fail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TosspaymentsWidgetWebview(executeJS: (WebViewController controller) {
      controller.evaluateJavascript('''
          var clientKey = '$clientKey';
          var tossPayments = TossPayments(clientKey);
          tossPayments.requestPayment('${data.paymentMethod}', ${jsonEncode(data.toJson())});
          ''');
    }, didSuccess: (String url) {
      final Success? result = successFromUrl(url);
      if (result != null) {
        success(result);
        return true;
      }
      return false;
    }, didFail: (String url) {
      final Fail? result = failFromUrl(url);
      if (result != null) {
        fail(result);
        return true;
      }
      return false;
    });
  }

  Success? successFromUrl(String urlString) {
    if (urlString.startsWith(Constants.success)) {
      final Uri url = Uri.parse(urlString);
      final Map<String, String> queryParams = url.queryParameters;
      final String? paymentKey = queryParams['paymentKey'];
      final String? orderId = queryParams['orderId'];
      final num? amount = num.tryParse(queryParams['amount'] ?? '');

      if (paymentKey != null && orderId != null && amount != null) {
        return Success(paymentKey, orderId, amount);
      }
    }
    return null;
  }

  Fail? failFromUrl(String urlString) {
    if (urlString.startsWith(Constants.fail)) {
      final Uri url = Uri.parse(urlString);
      final Map<String, String> queryParams = url.queryParameters;
      final String? errorCode = queryParams['code'];
      final String? errorMessage = queryParams['message'];
      final String? orderId = queryParams['orderId'];

      if (errorCode != null && errorMessage != null && orderId != null) {
        return Fail(errorCode, errorMessage, orderId);
      }
    }
    return null;
  }
}
