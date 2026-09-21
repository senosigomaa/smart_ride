import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SmartRideModernApp());
}

class SmartRideModernApp extends StatelessWidget {
  const SmartRideModernApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRide Modern',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F5F9),
        fontFamily: 'Tajawal',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4A00E0),
          secondary: Color(0xFFFF007F),
        ),
      ),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const ModernSplashScreen(),
    );
  }
}

// ==========================================
// 1. شاشة الافتتاحية
// ==========================================
class ModernSplashScreen extends StatefulWidget {
  const ModernSplashScreen({super.key});

  @override
  State<ModernSplashScreen> createState() => _ModernSplashScreenState();
}

class _ModernSplashScreenState extends State<ModernSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ModernHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
              ),
              child: const Icon(Icons.electric_car_rounded, color: Colors.white, size: 70),
            ),
            const SizedBox(height: 25),
            const Text(
              'SmartRide',
              style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 1.5),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('المستقبل في طريقك', style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. الشاشة الرئيسية (Home Screen)
// ==========================================
class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen> {
  int _selectedService = 3; // 3 يعني مشترك

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية خريطة حقيقية بدلاً من اللون الرمادي
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://snazzy-maps-cdn.azureedge.net/assets/74-become-a-dinosaur.png?v=20170626082939'), // صورة خريطة واقعية فاتحة
                fit: BoxFit.cover,
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
                  // زرار المعاملات / المحفظة
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
                          Icon(Icons.wallet_rounded, color: Color(0xFF4A00E0), size: 20),
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
                boxShadow: [
                  BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.15), blurRadius: 30, spreadRadius: 5, offset: const Offset(0, 10)),
                ],
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
                        _buildInputField(Icons.my_location_rounded, const Color(0xFF4A00E0), 'الشيخ زايد، المحور المركزي'),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 1, indent: 50, endIndent: 20),
                        _buildInputField(Icons.location_on_rounded, const Color(0xFFFF007F), 'إلى أين تريد الذهاب؟', isHint: true),
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
                      gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
                      boxShadow: [BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ModernSearchingScreen()));
                        },
                        child: const Center(
                          child: Text(
                            'تأكيد وبحث عن رحلة',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
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
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
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
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: isHint ? FontWeight.w500 : FontWeight.bold, color: isHint ? Colors.black45 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // هذه الدالة الآن تقوم بتحديث الحالة فقط ولا تنتقل لشاشة أخرى
  Widget _buildServicePill(int index, IconData icon, String title) {
    bool isSelected = _selectedService == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedService = index; // تغيير الحالة في نفس الشاشة
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A00E0) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? const Color(0xFF4A00E0) : Colors.grey.withOpacity(0.2)),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] : [],
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

// ==========================================
// 3. شاشة البحث (Searching)
// ==========================================
class ModernSearchingScreen extends StatefulWidget {
  const ModernSearchingScreen({super.key});

  @override
  State<ModernSearchingScreen> createState() => _ModernSearchingScreenState();
}

class _ModernSearchingScreenState extends State<ModernSearchingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ModernOffersScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white, Color(0xFFF3F5F9)]),
            ),
          ),
          SafeArea(
            child: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87), onPressed: () => Navigator.pop(context)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(width: 100, height: 100, child: CircularProgressIndicator(valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A00E0)), strokeWidth: 3, backgroundColor: const Color(0xFF4A00E0).withOpacity(0.1))),
                    const Icon(Icons.search_rounded, color: Color(0xFFFF007F), size: 40),
                  ],
                ),
                const SizedBox(height: 40),
                const Text('جاري إرسال طلبك...', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                const Text('ننتظر عروض الأسعار من الكباتن المتاحين', style: TextStyle(color: Colors.black54, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. شاشة العروض (Offers)
// ==========================================
class ModernOffersScreen extends StatelessWidget {
  const ModernOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('عروض الكباتن', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildOfferCard(context, 'كريم طارق', 'هيونداي إلنترا', '35 EGP', '5 دقائق', 4.9, 'https://randomuser.me/api/portraits/men/32.jpg', isBestPrice: true),
          _buildOfferCard(context, 'محمود علي', 'نيسان صني', '40 EGP', '3 دقائق', 4.8, 'https://randomuser.me/api/portraits/men/44.jpg'),
        ],
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, String name, String car, String price, String time, double rating, String imageUrl, {bool isBestPrice = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: isBestPrice ? Border.all(color: const Color(0xFFFF007F).withOpacity(0.5), width: 2) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage(imageUrl), // صورة حقيقية للكابتن
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(car, style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 16),
                        Text(' $rating', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(width: 15),
                        const Icon(Icons.access_time_rounded, color: Colors.black45, size: 16),
                        Text(' $time', style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isBestPrice)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: const Color(0xFFFF007F).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Text('أفضل سعر', style: TextStyle(color: Color(0xFFFF007F), fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  Text(price, style: const TextStyle(color: Color(0xFF4A00E0), fontSize: 22, fontWeight: FontWeight.w900)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
                    boxShadow: [BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ModernMatchedScreen()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Center(child: Text('قبول العرض', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ==========================================
// 5. شاشة الكابتن بعد القبول (Matched)
// ==========================================
class ModernMatchedScreen extends StatelessWidget {
  const ModernMatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خريطة واقعية هنا أيضاً
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://snazzy-maps-cdn.azureedge.net/assets/74-become-a-dinosaur.png?v=20170626082939'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                child: IconButton(icon: const Icon(Icons.close_rounded, color: Colors.black), onPressed: () => Navigator.pop(context)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('كريم طارق', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 20),
                            Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(' (1.2k رحلة)', style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFFF4F6F9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.withOpacity(0.1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('هيونداي إلنترا', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text('فضي اللون', style: TextStyle(color: Colors.black54, fontSize: 13)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF4A00E0).withOpacity(0.3))),
                                child: const Text('أ ب ج 123', style: TextStyle(color: Color(0xFF4A00E0), fontWeight: FontWeight.w900, fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                // فتح شاشة الشات
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                                },
                                style: TextButton.styleFrom(backgroundColor: const Color(0xFF4A00E0).withOpacity(0.1), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                icon: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF4A00E0)),
                                label: const Text('محادثة', style: TextStyle(color: Color(0xFF4A00E0), fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A00E0), padding: const EdgeInsets.symmetric(vertical: 16), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                icon: const Icon(Icons.phone_rounded, color: Colors.white),
                                label: const Text('اتصال', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 85, height: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
                        border: Border.all(color: Colors.white, width: 4),
                        // استخدام صورة حقيقية بدلاً من الأيقونة
                        image: const DecorationImage(
                          image: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                          fit: BoxFit.cover,
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
}

// ==========================================
// 6. شاشة المحادثة (Chat Screen)
// ==========================================
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg')),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('كريم طارق', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('متصل الآن', style: TextStyle(color: Color(0xFF00C853), fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessageBubble('أهلاً بيك يا فندم، أنا في الطريق', false),
                _buildMessageBubble('تمام، أنا منتظر عند بوابة المول', true),
                _buildMessageBubble('دقيقتين بالظبط وهكون عند حضرتك', false),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: const Color(0xFFF4F6F9), borderRadius: BorderRadius.circular(25)),
                      child: const TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: 'اكتب رسالة...'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFF4A00E0), shape: BoxShape.circle),
                    child: IconButton(icon: const Icon(Icons.send_rounded, color: Colors.white), onPressed: () {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF4A00E0) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ==========================================
// 7. شاشة المعاملات / المحفظة (Transaction Screen)
// ==========================================
class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('المحفظة والمعاملات', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // كارت الرصيد
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
                boxShadow: [BoxShadow(color: const Color(0xFF4A00E0).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  const Text('120.00 EGP', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, foregroundColor: const Color(0xFF4A00E0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text('شحن المحفظة'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // المعاملات الأخيرة
            Align(
              alignment: Alignment.centerRight,
              child: const Text('المعاملات الأخيرة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildTransactionItem('رحلة إلى الدقي', '14 سبتمبر 2026', '-45 EGP', true),
                  _buildTransactionItem('شحن رصيد (فيزا)', '10 سبتمبر 2026', '+100 EGP', false),
                  _buildTransactionItem('رحلة إلى أكتوبر', '5 سبتمبر 2026', '-60 EGP', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, bool isDeduction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDeduction ? const Color(0xFFFF007F).withOpacity(0.1) : const Color(0xFF00C853).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(isDeduction ? Icons.directions_car_rounded : Icons.account_balance_wallet_rounded, color: isDeduction ? const Color(0xFFFF007F) : const Color(0xFF00C853)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.black45, fontSize: 13)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDeduction ? Colors.black87 : const Color(0xFF00C853))),
        ],
      ),
    );
  }
}
