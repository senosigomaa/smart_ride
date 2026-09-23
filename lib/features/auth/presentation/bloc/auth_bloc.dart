import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<CodeSentEvent>(_onCodeSent);
    on<AuthErrorEvent>(_onAuthError);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  // دالة التعامل مع ضغطة زر إرسال الكود
  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // أظهر التحميل
    await authRepository.verifyPhone(
      phoneNumber: event.phoneNumber,
      onCodeSent: (String verificationId) {
        add(CodeSentEvent(verificationId)); // أول ما يوصل الكود، ابعت حدث للـ BLoC
      },
      onError: (String error) {
        add(AuthErrorEvent(error)); // لو حصل خطأ
      },
    );
  }

  void _onCodeSent(CodeSentEvent event, Emitter<AuthState> emit) {
    emit(AuthCodeSent(event.verificationId)); // غيّر الحالة عشان ينقله لشاشة الـ OTP
  }

  void _onAuthError(AuthErrorEvent event, Emitter<AuthState> emit) {
    emit(AuthError(event.error)); // أظهر رسالة الخطأ للمستخدم
  }

  // دالة التعامل مع ضغطة زر تأكيد الكود
  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signInWithOtp(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      emit(AuthVerified()); // تم الدخول بنجاح! هينقله للشاشة الرئيسية
    } catch (e) {
      emit(AuthError('الكود غير صحيح أو منتهي الصلاحية'));
    }
  }
}
