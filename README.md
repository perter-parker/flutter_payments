# flutter_payments

플러터 결제 예제 프로젝트입니다.

## 시작하기

이 프로젝트는 플러터 애플리케이션의 시작점입니다.

처음으로 플러터 프로젝트를 시작하는 경우에 도움이 될 몇 가지 자료들입니다:

- [Lab: 첫 번째 플러터 앱 작성하기](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: 유용한 플러터 샘플들](https://docs.flutter.dev/cookbook)

플러터 개발을 시작하는 데 도움이 필요한 경우, 튜토리얼, 샘플 코드, 모바일 개발에 대한 안내 및 전체 API 참조를 제공하는
[온라인 문서](https://docs.flutter.dev/)를 참조하세요.

## 아임포트 패키지 사용 가이드

아임포트 패키지는 한국에서 널리 사용되는 결제 서비스인 아임포트(Iamport)를 통합하기 위한 플러터 패키지입니다. 아임포트를 사용하여 앱에서 간편하게 결제를 처리할 수 있습니다.

아래는 아임포트 패키지의 사용법입니다:

1.  `pubspec.yaml` 파일에 아임포트 패키지를 추가합니다:

    ```yaml
    dependencies:
      iamport_flutter: ^버전_번호
    ```

2.  패키지를 가져온 다음, 결제 요청을 만들고 처리합니다:
    ```dart
    import 'package:iamport_flutter/iamport_payment.dart';
        void initiatePayment() {
        String userCode = "아임포트에서 발급받은 사용자 코드";
        String orderId = "고유 주문 번호";
        int price = 1000; // 결제할 금액
    
            IamportPayment.requestPayment(
                userCode: userCode,
                data: IamportRequest(
                pg: "아임포트에서 지원하는 PG사",
                payMethod: "결제 수단",
                name: "상품명",
                merchantUid: orderId,
                amount: price,
                // 추가 필요한 정보들
                ),
            ).then((response) {
                // 결제 완료 후 처리할 작업
                print('결제 완료: ${response.toJson()}');
            }).catchError((error) {
                // 결제 실패 시 처리할 작업
                print('결제 실패: $error');
            });
        }
    ```

위 코드에서 userCode는 아임포트에서 발급받은 사용자 코드입니다. orderId는 고유한 주문 번호로, 결제마다 고유해야 합니다. price는 결제할 금액을 나타냅니다. 그리고 pg, payMethod, name 등의 필요한 정보들을 설정한 후, IamportPayment.requestPayment()를 호출하여 결제를 요청합니다.

결제가 완료되면 then 블록이 실행되고, 결제 실패 시 catchError 블록이 실행됩니다. 이 블록들에서는 결제 완료 후나 실패 시 수행할 작업을 구현할 수 있습니다.

이렇게 함으로써 플러터 앱에서 아임포트 결제를 간편하게 처리할 수 있습니다. 자세한 내용은 iamport_flutter 패키지 문서를 참조하세요.
