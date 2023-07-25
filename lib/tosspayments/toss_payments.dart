// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_payments/tosspayments_sdk/model/paymentData.dart';
import 'package:flutter_payments/tosspayments_sdk/tosspayments_sdk.dart';

class EasyPay {
  final String ko;
  final String us;
  final Color color;

  EasyPay({
    required this.ko,
    required this.us,
    required this.color,
  });
}

List<EasyPay> easyPayList = [
  EasyPay(ko: '토스페이', us: 'TOSSPAY', color: Colors.blue),
  EasyPay(ko: '네이버페이', us: 'NAVERPAY', color: Colors.green),
  EasyPay(ko: '삼성페이', us: 'SAMSUNGPAY', color: Colors.blue.shade900),
  EasyPay(ko: '애플페이', us: 'APPLEPAY', color: Colors.grey),
  EasyPay(ko: '엘페이', us: 'LPAY', color: Colors.purple),
  EasyPay(ko: '카카오페이', us: 'KAKAOPAY', color: Colors.yellow),
  EasyPay(ko: '페이코', us: 'PAYCO', color: Colors.red.shade400),
  EasyPay(ko: 'SSG페이', us: 'SSG', color: Colors.orange),
];

class CardCompany {
  final String company;
  final String code;
  final String ko;
  final String us;
  CardCompany({
    required this.company,
    required this.code,
    required this.ko,
    required this.us,
  });
}

List<CardCompany> cardCompnayList = [
  CardCompany(company: '은행선택', code: '', ko: '', us: 'us'),
  CardCompany(company: '기업 BC', code: '3K', ko: '기업비씨', us: 'IBK_BC'),
  CardCompany(company: '광주은행', code: '46', ko: '광주', us: 'GWANGJUBANK'),
  CardCompany(company: '롯데카드', code: '71', ko: '롯데', us: 'LOTTE'),
  CardCompany(company: 'KDB산업은행', code: '30', ko: '산업', us: 'KDBBANK'),
  CardCompany(company: 'BC카드', code: '31', ko: '-', us: 'BC'),
  CardCompany(company: '삼성카드', code: '51', ko: '삼성', us: 'SAMSUNG'),
  CardCompany(company: '새마을금고', code: '38', ko: '새마을', us: 'SAEMAUL'),
  CardCompany(company: '신한카드', code: '41', ko: '신한', us: 'SHINHAN'),
  CardCompany(company: '신협', code: '62', ko: '신협', us: 'SHINHYEOP'),
  CardCompany(company: '씨티카드', code: '36', ko: '씨티', us: 'CITI'),
  CardCompany(company: '우리BC카드', code: '33', ko: '우리', us: 'WOORI'),
  CardCompany(company: '우리카드', code: 'W1', ko: '우리', us: 'WOORI'),
  CardCompany(company: '우체국예금보험', code: '37', ko: '우체국', us: 'POST'),
  CardCompany(company: '저축은행중앙회', code: '39', ko: '저축', us: 'SANINGBANK'),
  CardCompany(company: '전북은행', code: '35', ko: '전북', us: 'JEONBUKBANK'),
  CardCompany(company: '제주은행', code: '42', ko: '제주', us: 'JEJUBANK'),
  CardCompany(company: '카카오뱅크', code: '15', ko: '카카오뱅크', us: 'KAKAOBANK'),
  CardCompany(company: '케이뱅크', code: '3A', ko: '케이뱅크', us: 'KBANK'),
  CardCompany(company: '토스뱅크', code: '24', ko: '토스뱅크', us: 'TOSSBANK'),
  CardCompany(company: '하나카드', code: '21', ko: '하나', us: 'HANA'),
  CardCompany(company: '현대카드', code: '61', ko: '현대', us: 'HYUNDAI'),
  CardCompany(company: 'KB국민카드', code: '11', ko: '국민', us: 'KOOKMIN'),
  CardCompany(company: 'NH농협카드', code: '91', ko: '농협', us: 'NONGHYEOP'),
  CardCompany(company: 'SH수협은행', code: '34', ko: '수협', us: 'SUHYEP'),
];

class TosspaymentsScreen extends StatefulWidget {
  const TosspaymentsScreen({super.key});

  @override
  State<TosspaymentsScreen> createState() => _TosspaymentsScreenState();
}

class _TosspaymentsScreenState extends State<TosspaymentsScreen> {
  bool isWebView = false;
  String selectedCardCompany = '';

  Widget tosspay() {
    return TossPayments(
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
      success: null,
      fail: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("토스페이먼츠"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 카드 결제
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (selectedCardCompany != '') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TossPayments(
                              clientKey: 'test_ck_BE92LAa5PVbzmkqd0LZV7YmpXyJj',
                              data: PaymentData(
                                paymentMethod: '카드',
                                orderId: 'tosspayments-202303210239',
                                orderName: 'toss t-shirt',
                                amount: 50000,
                                customerName: '김토스',
                                customerEmail: 'toss@toss-payments.co.kr',
                                flowMode: 'DIRECT',
                                cardCompany: selectedCardCompany,
                              ),
                              success: null,
                              fail: null,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('은행을 선택해주세요.')));
                      }
                    },
                    child: const Text('일반결제'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: DropdownButton(
                    hint: const Text('은행 선택'),
                    isExpanded: true,
                    value: selectedCardCompany,
                    items: cardCompnayList
                        .map((cardcompany) => DropdownMenuItem(
                              value: cardcompany.code,
                              child: Text(cardcompany.company),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCardCompany = value ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),

            // 가상, 계좌, 핸드폰
            Expanded(
              flex: 1,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 2, //item 의 가로 1, 세로 2 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                children: [
                  // 가상계좌
                  methodButton(context, '가상계좌'),

                  // 휴대폰
                  methodButton(context, '휴대폰'),

                  // 계좌이체
                  methodButton(context, '계좌이체'),
                ],
              ),
            ),

            // 간편결제
            Expanded(
              flex: 3,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 2, //item 의 가로 1, 세로 2 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                children: List.generate(
                  easyPayList.length,
                  (index) => EasyPaymentButton(
                    text: easyPayList[index].ko,
                    backgroundColor: easyPayList[index].color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding methodButton(BuildContext context, String method) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1.0, color: Colors.black),
          minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TossPayments(
                clientKey: 'test_ck_BE92LAa5PVbzmkqd0LZV7YmpXyJj',
                data: PaymentData(
                  paymentMethod: method,
                  orderId: 'tosspayments-202303210239',
                  orderName: 'toss t-shirt',
                  amount: 50000,
                  customerName: '김토스',
                  customerEmail: 'toss@toss-payments.co.kr',
                ),
                success: null,
                fail: null,
              ),
            ),
          );
        },
        child: Text(method),
      ),
    );
  }
}

class EasyPaymentButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  const EasyPaymentButton({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TossPayments(
                clientKey: 'test_ck_BE92LAa5PVbzmkqd0LZV7YmpXyJj',
                data: PaymentData(
                  paymentMethod: '카드',
                  orderId: 'tosspayments-202303210239',
                  orderName: 'toss t-shirt',
                  amount: 50000,
                  customerName: '김토스',
                  customerEmail: 'toss@toss-payments.co.kr',
                  flowMode: 'DIRECT',
                  easyPay: text.replaceAll(RegExp('\\s'), ""),
                ),
                success: null,
                fail: null,
              ),
            ),
          );
        },
        child: Text(text),
      ),
    );
  }
}
