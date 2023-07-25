import 'package:flutter/material.dart';
import 'package:flutter_payments/tosspayments/toss_payments.dart';
import 'package:flutter_payments/tosspayments_sdk/model/paymentData.dart';
import 'package:flutter_payments/tosspayments_sdk/tosspayments_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('결제 방법 선택')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TosspaymentsScreen()));
                  },
                  child: const Text('일반결제/간편결제'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TossPaymentsWidget(
                          clientKey: 'test_ck_BE92LAa5PVbzmkqd0LZV7YmpXyJj',
                          data: PaymentData(
                            paymentMethod: '카드',
                            orderId: 'tosspayments-202303210239',
                            orderName: 'toss t-shirt',
                            amount: 50000,
                            customerName: '김토스',
                            customerEmail: 'toss@toss-payments.co.kr',
                            flowMode: 'DIRECT',
                            easyPay: "토스페이",
                          ),
                          fail: null,
                          success: null,
                        ),
                      ),
                    );
                  },
                  child: const Text('결제위젯(토스제공)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
