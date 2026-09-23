import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {} // شاشة التحميل الدوارة

class AuthCodeSent extends AuthState { // الكود اتبعت بنجاح
  final String verificationId;
  AuthCodeSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class AuthVerified extends AuthState {} // تم تسجيل الدخول بنجاح

class AuthError extends AuthState { // فيه خطأ ظهر
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
