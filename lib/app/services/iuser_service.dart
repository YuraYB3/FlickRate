abstract interface class IUserService {
  Future<void> loginWithOtp(String otp);
  void loginWithGoogle();
  void logout();
}
