// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_payments/tosspayments_sdk/model/tosspayments_url.dart';
import 'package:tosspayments_webview_flutter/tosspayments_webview_flutter.dart';

enum ActionType { auth, payment }

class TosspaymentsWebview extends StatelessWidget {
  static const String html = '''
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <script src="https://js.tosspayments.com/v1/payment"></script>
        <script type='text/javascript'>
          TosspaymentsReady.postMessage('');
        </script>
      </head>
      <body>      
      </body>
    </html>
  ''';

  static const String test1 = ''' 
    <html lang="ko">
      <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/svg+xml" href="/vite.svg" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>결제위젯 샘플</title>
        <script src="https://js.tosspayments.com/v1/payment-widget"></script>
      </head>
      <body>
        <div id="payment-method"></div>
        <button id="payment-request-button">결제하기</button>
        <script type="module" src="./index.js"></script>
      </body>
    </html>
  ''';

  static const String paymentWidget = '''
    <html>
      <head>
        <meta httpEquiv="x-ua-compatible" content="ie=edge" />
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />
        <link rel="stylesheet" href="/stylesheets/style.css" />
      </head>
      <body>
        <section>
          <h1>구매하기</h1>
          <h3><%= orderName %></h3>
          <span><%= price.toLocaleString() %>원</span>
          <div id="payment-widget"></div>
          <button id="payment-button">결제하기</button>
        </section>
        <script src="https://js.tosspayments.com/v1/payment-widget"></script>
        <script>
          const paymentWidget = PaymentWidget(
            "test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq",
            PaymentWidget.ANONYMOUS
          );

          paymentWidget.renderPaymentMethods("#payment-widget", {
            value: "<%= price %>",
          });

          const button = document.getElementById("payment-button");

          button.addEventListener("click", function () {
            paymentWidget.requestPayment({
              orderId: "<%= orderId %>",
              orderName: "<%= orderName %>",
              customerName: "<%= customerName %>",
              successUrl: window.location.origin + "/success",
              failUrl: window.location.origin + "/fail",
            });
          });
        </script>
      </body>
    </html>
  ''';

  final ValueSetter<WebViewController> executeJS;
  final Function didSuccess;
  final Function didFail;

  late WebViewController _webViewController;

  TosspaymentsWebview({super.key, required this.executeJS, required this.didSuccess, required this.didFail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          children: [
            WebView(
              initialUrl: Uri.dataFromString(TosspaymentsWebview.html,
                      mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>{
                JavascriptChannel(
                    name: "TosspaymentsReady",
                    onMessageReceived: (JavascriptMessage message) {
                      executeJS(_webViewController);
                    })
              },
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              navigationDelegate: (request) async {
                // 웹뷰 화면 전환 시 실행
                //원천사 인증 완료시
                if (didSuccess(request.url)) {
                  return NavigationDecision.prevent;
                }

                if (didFail(request.url)) {
                  return NavigationDecision.prevent;
                }

                if (request.url.startsWith('intent')) {
                  return tossPaymentsWebview(request.url);
                }

                tossPaymentsWebview(request.url);

                return NavigationDecision.navigate;
              },
            ),
          ],
        ),
      ),
    );
  }
}

tossPaymentsWebview(url) {
  final convertUrl = ConvertUrl(url);

  // 앱링크일시 convert하기 위해
  if (convertUrl.isAppLink()) {
    convertUrl.launchApp();
    return NavigationDecision.prevent;
  }
}
