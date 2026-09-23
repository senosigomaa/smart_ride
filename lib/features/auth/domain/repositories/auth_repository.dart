abstract class AuthRepository {
  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  });
  
  Future<void> signInWithOtp({
    required String verificationId,
    required String smsCode,
  });
}
