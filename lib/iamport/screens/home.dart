import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff344e81)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0,
                      top: 20.0,
                      right: 0,
                      bottom: 20.0,
                    ),
                    child: Text(
                      '아임포트 테스트',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        height: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아임포트 플러터 모듈 테스트 화면입니다.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아래 버튼을 눌러 결제 또는 본인인증 테스트를 진행해주세요.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  top: 50.0,
                  right: 0,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        icon: const Icon(
                          Icons.payment,
                          color: Colors.white,
                          size: 25,
                        ),
                        label: const Text(
                          '결제 테스트',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/payments');
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        icon: const Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 25,
                        ),
                        label: const Text(
                          '본인인증 테스트',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/certification-test');
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
