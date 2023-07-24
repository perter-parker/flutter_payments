import 'dart:core';

abstract class TossPaymentResult {}

class Success extends TossPaymentResult {
  Success(this.paymentKey, this.orderId, this.amount);

  final String paymentKey;
  final String orderId;
  final num amount;
}

class Fail extends TossPaymentResult {
  Fail(this.errorCode, this.errorMessage, this.orderId);

  final String errorCode;
  final String errorMessage;
  final String orderId;
}
