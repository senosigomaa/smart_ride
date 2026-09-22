import 'package:flutter/material.dart';
import 'package:smart_ride/core/theme/app_theme.dart';
import 'searching_screen.dart';
import '../../../wallet/presentation/pages/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedService = 3; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. استخدام رابط خريطة مستقر لا يسبب خطأ 403
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.lightBgColor,
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=800&auto=format&fit=crop'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  _buildFloatingIcon(Icons.sort_rounded),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.wallet_rounded, color: AppTheme.primaryColor, size: 20),
                          SizedBox(width: 8),
                          Text('120 EGP', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildFloatingIcon(Icons.notifications_active_rounded),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        _buildInputField(Icons.my_location_rounded, AppTheme.primaryColor, 'الشيخ زايد، المحور المركزي'),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 1, indent: 50, endIndent: 20),
                        _buildInputField(Icons.location_on_rounded, AppTheme.secondaryColor, 'إلى أين تريد الذهاب؟', isHint: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildServicePill(0, Icons.directions_car_rounded, 'سيارة'),
                        _buildServicePill(1, Icons.two_wheeler_rounded, 'موتوسيكل'),
                        _buildServicePill(2, Icons.directions_bus_rounded, 'باص'),
                        _buildServicePill(3, Icons.handshake_rounded, 'مشترك'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchingScreen()));
                        },
                        child: const Center(
                          child: Text('تأكيد وبحث عن رحلة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon) {
    return Container(
      width: 48, height: 48,
      decoration: BoxDecoration(
        color: Colors.white, shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Icon(icon, color: Colors.black87),
    );
  }

  Widget _buildInputField(IconData icon, Color iconColor, String text, {bool isHint = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16, fontWeight: isHint ? FontWeight.w500 : FontWeight.bold, color: isHint ? Colors.black45 : Colors.black87))),
        ],
      ),
    );
  }

  // 2. حل جذري لمشكلة الأنيميشن والشاشة الحمراء
  Widget _buildServicePill(int index, IconData icon, String title) {
    bool isSelected = _selectedService == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedService = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250), // سرعة أفضل للأنيميشن
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              // نغير لون الظل لشفاف بدل ما نغير الـ blurRadius للصفر عشان نمنع الخطأ السالب
              color: isSelected ? AppTheme.primaryColor.withOpacity(0.3) : Colors.transparent,
              blurRadius: 10.0, // القيمة ثابتة عشان فلاتر ميتلخبطش
              offset: const Offset(0, 4), // القيمة ثابتة
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black54, size: 22),
            if (isSelected) const SizedBox(width: 8),
            if (isSelected) Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
