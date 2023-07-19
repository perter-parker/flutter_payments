import 'package:flutter/material.dart';
import 'package:flutter_payments/iamport/model/method.dart';
import 'package:flutter_payments/iamport/model/quota.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:iamport_flutter/model/pg/kcp/kcp_products.dart';
import 'package:iamport_flutter/model/pg/naver/naver_pay_products.dart';

import '../model/pg.dart';

class PaymentTest extends StatefulWidget {
  const PaymentTest({super.key});

  @override
  State<PaymentTest> createState() => _PaymentTestState();
}

class _PaymentTestState extends State<PaymentTest> {
  final _formKey = GlobalKey<FormState>();
  String pg = 'html5_inicis'; // PG사
  String payMethod = 'card'; // 결제수단
  String cardQuota = '0'; // 할부개월수
  late String vbankDue; // 가상계좌 입금기한
  late String bizNum; // 사업자번호
  bool digital = false; // 실물컨텐츠 여부
  bool escrow = false; // 에스크로 여부
  late String name; // 주문명
  late String amount; // 결제금액
  late String merchantUid; // 주문번호
  late String buyerName; // 구매자 이름
  late String buyerTel; // 구매자 전화번호
  late String buyerEmail; // 구매자 이메일

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아임포트 결제 테스트'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'PG사',
                ),
                value: pg,
                onChanged: (String? value) {
                  setState(() {
                    pg = value!;
                    payMethod = Method.getValueByPg(value);
                  });
                },
                items: Pg.getLists().map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(Pg.getLabel(value)),
                  );
                }).toList(),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: '결제수단',
                ),
                value: payMethod,
                onChanged: (String? value) {
                  setState(() {
                    payMethod = value!;
                  });
                },
                items: Method.getListsByPg(pg).map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(Method.getLabel(value)),
                  );
                }).toList(),
              ),
              payMethod == 'card'
                  ? DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: '할부개월수',
                      ),
                      value: cardQuota,
                      onChanged: (String? value) {
                        setState(() {
                          cardQuota = value!;
                        });
                      },
                      items: Quota.getListsByPg(pg).map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(Quota.getLabel(value)),
                        );
                      }).toList(),
                    )
                  : Container(),
              payMethod == 'vbank'
                  ? TextFormField(
                      decoration: const InputDecoration(
                        labelText: '입금기한',
                        hintText: 'YYYYMMDDhhmm',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return '입금기한은 필수입력입니다';
                        if (value.isNotEmpty) {
                          RegExp regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) return '입금기한이 올바르지 않습니다.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (String? value) {
                        vbankDue = value!;
                      },
                    )
                  : Container(),
              payMethod == 'vbank' && pg == 'danal_tpay'
                  ? TextFormField(
                      decoration: const InputDecoration(
                        labelText: '사업자번호',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return '사업자번호는 필수입력입니다';
                        if (value.isNotEmpty) {
                          RegExp regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) return '사업자번호가 올바르지 않습니다.';
                          if (value.length != 10) return '사업자번호는 10자리 숫자입니다.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (String? value) {
                        bizNum = value!;
                      },
                    )
                  : Container(),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '주문명',
                ),
                initialValue: '아임포트 결제 데이터 분석',
                validator: (value) => value!.isEmpty ? '주문명은 필수입력입니다' : null,
                onSaved: (String? value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '결제금액',
                ),
                initialValue: '39000',
                validator: (value) {
                  if (value!.isEmpty) {
                    return '결제금액은 필수입력입니다.';
                  }
                  if (value.isNotEmpty) {
                    RegExp regex = RegExp(r'^\d+(\.\d+)?$');
                    if (!regex.hasMatch(value)) return '결제금액이 올바르지 않습니다.';
                  }
                  return null;
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (String? value) {
                  amount = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '주문번호',
                ),
                validator: (value) => value!.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String? value) {
                  merchantUid = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
                initialValue: '홍길동',
                onSaved: (String? value) {
                  buyerName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
                initialValue: '01012341234',
                validator: (value) {
                  if (value!.isNotEmpty) {
                    RegExp regex = RegExp(r'^[0-9]+$');
                    if (!regex.hasMatch(value)) return '전화번호가 올바르지 않습니다.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  buyerTel = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '이메일',
                ),
                initialValue: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                onSaved: (String? value) {
                  buyerEmail = value!;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('creating payment data...');

                      PaymentData data = PaymentData(
                        pg: pg,
                        payMethod: payMethod,
                        escrow: escrow,
                        name: name,
                        amount: num.parse(amount),
                        merchantUid: merchantUid,
                        buyerName: buyerName,
                        buyerTel: buyerTel,
                        buyerEmail: buyerEmail,
                        appScheme: 'flutterexample',
                        niceMobileV2: true,
                      );
                      if (payMethod == 'card' && cardQuota != '0') {
                        data.cardQuota = [];
                        if (cardQuota != '1') {
                          data.cardQuota!.add(int.parse(cardQuota));
                        }
                      }

                      // 가상계좌의 경우, 입금기한 추가
                      if (payMethod == 'vbank') {
                        data.vbankDue = vbankDue;

                        // 다날 && 가상계좌의 경우, 사업자 등록번호 10자리 추가
                        if (pg == 'danal_tpay') {
                          data.bizNum = bizNum;
                        }
                      }

                      // 휴대폰 소액결제의 경우, 실물 컨텐츠 여부 추가
                      if (payMethod == 'phone') {
                        data.digital = digital;
                        if (pg == 'danal') {
                          // 다날 && 휴대폰 소액결제의 경우, company 파라메터 추가
                          data.company = '아임포트';
                        }
                      }

                      // 정기결제의 경우, customer_uid 추가
                      if (pg == 'kcp_billing') {
                        data.customerUid = 'cuid_${DateTime.now().millisecondsSinceEpoch}';
                      }

                      // 네이버페이 관련 정보 추가
                      if (pg == 'naverpay') {
                        NaverPayProducts p = NaverPayProducts(
                          name: '한국사',
                          categoryId: 'GENERAL',
                          categoryType: 'BOOK',
                          count: 10,
                          uid: '107922211',
                          payReferrer: 'NAVER_BOOK',
                        );
                        data.naverUseCfm = '20231026';
                        data.naverCultureBenefit = false;
                        data.naverPopupMode = false;
                        data.naverProducts = [p];
                      }

                      // kcp 에스크로 관련 정보 추가
                      if (pg == 'kcp' && escrow == true) {
                        KcpProducts p = KcpProducts(
                          orderNumber: 'order1234',
                          name: '에스크로 주문',
                          quantity: 3,
                          amount: 5000,
                        );
                        data.kcpProducts = [p];
                      }

                      // [이니시스-빌링.나이스.다날] 제공기간 표기
                      data.period = {
                        'from': '20230101',
                        'to': '20231231',
                      };

                      data.popup = false;
                      Navigator.pushNamed(context, '/payment', arguments: data);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    '결제하기',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
