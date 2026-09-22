import 'package:flutter/material.dart';
import 'package:smart_ride/core/theme/app_theme.dart';
import '../../../chat/presentation/pages/chat_screen.dart';

class MatchedScreen extends StatelessWidget {
  const MatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // استخدام رابط الخريطة الجديد والمستقر لتجنب خطأ 403
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.lightBgColor,
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=800&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                opacity: 0.5, // لضبط إضاءة الخريطة وجعلها احترافية
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, 
                  shape: BoxShape.circle, 
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]
                ),
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.black), 
                  onPressed: () => Navigator.pop(context),
                ),
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
                      boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('كريم طارق', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.star_rounded, color: AppTheme.warningColor, size: 20),
                            Text(' 4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(' (1.2k رحلة)', style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F9), 
                            borderRadius: BorderRadius.circular(20), 
                            border: Border.all(color: Colors.grey.withOpacity(0.1))
                          ),
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
                                decoration: BoxDecoration(
                                  color: Colors.white, 
                                  borderRadius: BorderRadius.circular(12), 
                                  border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))
                                ),
                                child: const Text('أ ب ج 123', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w900, fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1), 
                                  padding: const EdgeInsets.symmetric(vertical: 16), 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                ),
                                icon: const Icon(Icons.chat_bubble_rounded, color: AppTheme.primaryColor),
                                label: const Text('محادثة', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor, 
                                  padding: const EdgeInsets.symmetric(vertical: 16), 
                                  elevation: 0, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                ),
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
