import 'package:flutter/material.dart';
import 'package:flutter_payments/iamport/utils/index.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentData data = ModalRoute.of(context)!.settings.arguments as PaymentData;

    return IamportPayment(
      appBar: AppBar(
        title: const Text('아임포트 결제'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      initialChild: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
      userCode: Utils.getUserCodeByPg(data.pg!),
      data: data,
      callback: (Map<String, String> result) {
        Navigator.popAndPushNamed(context, '/payment-result');
      },
    );
  }
}
