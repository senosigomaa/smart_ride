import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_ride/core/theme/app_theme.dart';
import 'offers_screen.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  @override
  void initState() {
    super.initState();
    // تحويل المستخدم لشاشة العروض بعد ثانيتين
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, AppTheme.backgroundColor],
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100, height: 100,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        strokeWidth: 3,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      ),
                    ),
                    const Icon(Icons.search_rounded, color: AppTheme.secondaryColor, size: 40),
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
