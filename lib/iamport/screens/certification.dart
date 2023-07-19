import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  static const String userCode = 'imp10391932';

  const Certification({super.key});

  @override
  Widget build(BuildContext context) {
    CertificationData data = ModalRoute.of(context)!.settings.arguments as CertificationData;

    return IamportCertification(
      appBar: AppBar(
        title: const Text('아임포트 본인인증'),
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
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        Navigator.popAndPushNamed(context, '/certification-result', arguments: result);
      },
    );
  }
}
