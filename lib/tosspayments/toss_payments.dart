import 'package:flutter/material.dart';
import 'package:tosspayments_sdk_flutter/model/paymentData.dart';
import 'package:tosspayments_sdk_flutter/tosspayments_sdk_flutter.dart';

class TosspaymentsScreen extends StatefulWidget {
  const TosspaymentsScreen({super.key});

  @override
  State<TosspaymentsScreen> createState() => _TosspaymentsScreenState();
}

class _TosspaymentsScreenState extends State<TosspaymentsScreen> {
  bool isWebView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('토스페이먼츠'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isWebView = !isWebView;
                  });
                },
                child: const Text('결재진행'),
              ),
            ),
            if (isWebView)
              Expanded(
                child: TossPayments(
                  clientKey: 'test_ck_BE92LAa5PVbzmkqd0LZV7YmpXyJj',
                  data: PaymentData(
                      paymentMethod: '카드',
                      orderId: 'tosspayments-202303210239',
                      orderName: 'toss t-shirt',
                      amount: 50000,
                      customerName: '김토스',
                      customerEmail: 'toss@toss-payments.co.kr'),
                  success: null,
                  fail: null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
