import 'package:flutter/material.dart';
import 'package:smart_ride/core/theme/app_theme.dart';
import 'package:smart_ride/features/auth/presentation/pages/otp_screen.dart';
import '../../../ride/presentation/pages/home_screen.dart'; // هنحتاجها بعد التخطي مؤقتاً

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // للتحكم في شكل حقل الإدخال عند التركيز (Focus)
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. الخلفية العلوية المتدرجة (Hero Background)
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF8E2DE2), AppTheme.primaryColor],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // أيقونة التطبيق بشكل فخم
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.electric_car_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'SmartRide',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'رحلتك الذكية تبدأ من هنا',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. الكارت العائم لتسجيل الدخول (Overlapping Floating Card)
            Container(
              margin: EdgeInsets.only(
                top:
                    MediaQuery.of(context).size.height *
                    0.32, // بيقطع الخلفية المتدرجة
                left: 24,
                right: 24,
                bottom: 30,
              ),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أهلاً بك مجدداً 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'أدخل رقم هاتفك للمتابعة وإنشاء حسابك أو تسجيل الدخول.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // 3. حقل إدخال رقم الهاتف الاحترافي (Phone Input Field)
                  FocusScope(
                    child: Focus(
                      onFocusChange: (focus) =>
                          setState(() => _isFocused = focus),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _isFocused
                              ? Colors.white
                              : const Color(0xFFF4F6F9),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: _isFocused
                                ? AppTheme.primaryColor
                                : Colors.grey.withOpacity(0.2),
                            width: _isFocused ? 2 : 1,
                          ),
                          boxShadow: _isFocused
                              ? [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(
                                      0.15,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            // كود الدولة
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: const [
                                  Text('🇪🇬', style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 8),
                                  Text(
                                    '+20',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            // حقل الإدخال
                            const Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '100 123 4567',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // 4. زر المتابعة (Gradient Button)
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E2DE2), AppTheme.primaryColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // محاكاة تسجيل الدخول والانتقال للرئيسية
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OtpScreen(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'إرسال كود التحقق (OTP)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // 5. الفاصل (Divider)
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey.withOpacity(0.3)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'أو سجل الدخول عبر',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey.withOpacity(0.3)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // 6. أزرار السوشيال ميديا (Social Login)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(Icons.apple, Colors.black),
                      const SizedBox(width: 20),
                      _buildSocialButton(
                        Icons.g_mobiledata_rounded,
                        Colors.redAccent,
                        size: 35,
                      ),
                      const SizedBox(width: 20),
                      _buildSocialButton(Icons.facebook_rounded, Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, {double size = 28}) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: size),
        onPressed: () {},
      ),
    );
  }
}
