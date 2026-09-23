import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
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
  
  // 1. إعدادات الخريطة
  final Completer<GoogleMapController> _controller = Completer();
  // موقع افتراضي (الشيخ زايد مثلاً) لحد ما الـ GPS يشتغل
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.0197, 31.0028), 
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _determinePosition(); // تشغيل الـ GPS أول ما الشاشة تفتح
  }

  // 2. دالة جلب الموقع الحالي (GPS)
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    
    // تحريك كاميرا الخريطة لموقع المستخدم فوراً
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 3. الخريطة الحقيقية
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true, // إظهار النقطة الزرقاء (موقعك)
            myLocationButtonEnabled: false, // هنخفي الزرار الافتراضي عشان الديزاين بتاعنا
            zoomControlsEnabled: false, // إخفاء أزرار الزوم +/-
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  _buildFloatingIcon(Icons.sort_rounded),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionScreen())),
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
          
          // 4. زر التمركز على موقعي (مخصص)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.42,
            right: 20,
            child: GestureDetector(
              onTap: _determinePosition,
              child: Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                child: const Icon(Icons.my_location_rounded, color: AppTheme.primaryColor),
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
                        _buildInputField(Icons.my_location_rounded, AppTheme.primaryColor, 'موقعك الحالي'),
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
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))]),
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

  Widget _buildServicePill(int index, IconData icon, String title) {
    bool isSelected = _selectedService == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedService = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: isSelected ? AppTheme.primaryColor.withOpacity(0.3) : Colors.transparent,
              blurRadius: 10.0,
              offset: const Offset(0, 4),
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
