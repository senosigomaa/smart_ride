import 'package:flutter/material.dart';
import 'package:smart_ride/core/theme/app_theme.dart';
import '../../../ride/presentation/pages/home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber; // لاستقبال رقم الهاتف من الشاشة السابقة
  const OtpScreen({super.key, this.phoneNumber = '+20 100 123 4567'});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. الخلفية العلوية المتدرجة
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
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Icon(Icons.mark_email_read_rounded, color: Colors.white, size: 60),
                    const SizedBox(height: 15),
                    const Text('كود التحقق', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ],
                ),
              ),
            ),

            // 2. الكارت العائم (Floating Card)
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.32,
                left: 24,
                right: 24,
                bottom: 30,
              ),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 15))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('أدخل الكود المرسل إلى', style: TextStyle(color: Colors.black54, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.phoneNumber, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: 1)),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.edit_rounded, color: AppTheme.secondaryColor, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // 3. مربعات إدخال الـ OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOtpBox(first: true, last: false),
                      _buildOtpBox(first: false, last: false),
                      _buildOtpBox(first: false, last: false),
                      _buildOtpBox(first: false, last: true),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // 4. زر التأكيد
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), AppTheme.primaryColor]),
                      boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // إتمام التسجيل والانتقال للرئيسية
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
                        },
                        child: const Center(
                          child: Text('تأكيد وحفظ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 5. إعادة إرسال الكود
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('لم تستلم الكود؟ ', style: TextStyle(color: Colors.black54, fontSize: 14)),
                      GestureDetector(
                        onTap: () {}, // محاكاة إعادة الإرسال
                        child: const Text('إعادة إرسال (00:59)', style: TextStyle(color: AppTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
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

  // مربع إدخال رقم واحد من الكود
  Widget _buildOtpBox({required bool first, required bool last}) {
    return Container(
      width: 65,
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: TextField(
        autofocus: first,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.primaryColor),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '', // إخفاء عداد الأحرف
          border: InputBorder.none,
        ),
      ),
    );
  }
}
