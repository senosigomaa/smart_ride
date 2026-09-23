import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// حدث إرسال رقم الهاتف
class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  SendOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

// حدث استقبال الـ ID من الفايربيز
class CodeSentEvent extends AuthEvent {
  final String verificationId;
  CodeSentEvent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

// حدث تأكيد الكود
class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;
  VerifyOtpEvent(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
}

// حدث خطأ
class AuthErrorEvent extends AuthEvent {
  final String error;
  AuthErrorEvent(this.error);

  @override
  List<Object?> get props => [error];
}
