import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedServiceIndex = 3; // الافتراضي: مشترك

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      body: Stack(
        children: [
          // 1. محاكاة خريطة احترافية (Dark Map Style)
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0B0F19)],
                center: Alignment.center,
                radius: 1.2,
              ),
            ),
            child: CustomPaint(
              painter: GridPainter(), // رسم شبكة خفيفة للمحاكاة
              child: const SizedBox.expand(),
            ),
          ),
          
          // علامة الموقع في منتصف الخريطة
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F2FE).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF00F2FE)),
                  ),
                  child: const Text(
                    'موقعك الحالي',
                    style: TextStyle(color: Color(0xFF00F2FE), fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.location_on, color: Color(0xFF00F2FE), size: 40),
              ],
            ),
          ),

          // 2. الهيدر العائم (Floating Header)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGlassIconButton(Icons.menu),
                  const Text(
                    'أين وجهتك؟',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
                    ),
                  ),
                  _buildGlassIconButton(Icons.notifications_none_rounded),
                ],
              ),
            ),
          ),

          // 3. اللوحة الزجاجية السفلية (Premium Glass Bottom Sheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF151B2B).withOpacity(0.6),
                        const Color(0xFF151B2B).withOpacity(0.9),
                      ],
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // حقول الإدخال
                      _buildLocationInputs(),
                      const SizedBox(height: 25),
                      
                      // اختيار الخدمات
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildServiceItem(0, Icons.directions_car_rounded, 'سيارة'),
                          _buildServiceItem(1, Icons.two_wheeler_rounded, 'موتوسيكل'),
                          _buildServiceItem(2, Icons.directions_bus_rounded, 'باص'),
                          _buildServiceItem(3, Icons.handshake_rounded, 'مشترك'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      
                      // الزر المضيء (Neon Button)
                      _buildNeonButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- أجزاء الواجهة (Widgets) ---

  Widget _buildGlassIconButton(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildLocationInputs() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.radio_button_checked, color: Color(0xFF00F2FE), size: 20),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  'الشيخ زايد، المحور المركزي',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(width: 2, height: 20, color: Colors.white24),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFFFE005C), size: 20),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  'إلى أين تريد الذهاب؟',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(int index, IconData icon, String label) {
    bool isActive = _selectedServiceIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedServiceIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        width: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsets.symmetric(vertical: isActive ? 18 : 14),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00F2FE).withOpacity(0.15) : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF00F2FE) : Colors.white.withOpacity(0.05),
            width: isActive ? 1.5 : 1,
          ),
          boxShadow: isActive
              ? [BoxShadow(color: const Color(0xFF00F2FE).withOpacity(0.3), blurRadius: 15, spreadRadius: 1)]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF00F2FE) : Colors.white54,
              size: isActive ? 32 : 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: isActive ? Colors.white : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F2FE).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // توجيه لشاشة البحث
          },
          child: const Center(
            child: Text(
              'تأكيد المشوار والبحث',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// كلاس مساعد لرسم شبكة احترافية على الخلفية لتعطي إيحاء الخريطة
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
