import 'package:digital_domi/screens/chat_screen.dart';
import 'package:digital_domi/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_domi/widgets/card_view.dart';
import 'package:digital_domi/widgets/map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBottomDialogVisible = false;
  double _currentSheetSize = 0.65;

  final String _locationName = "100 Martinique Ave";
  final String _locationImagePath = "lib/assets/images/location_image.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          MapView(dialogToggleFunc: _dialogToggleFunc),
          Positioned(
            top: 50.0,
            left: 25.0,
            right: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(Icons.account_circle_outlined, const ProfileScreen()),
                _buildLocationInfo(),
                _buildIconButton(CupertinoIcons.chat_bubble_text, const ChatScreen()),
              ],
            ),
          ),
          if (!_isBottomDialogVisible)
            CardView(
                initialSize: _currentSheetSize,
                onSizeChanged: _updateSheetSize),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Widget widget) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff111111),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => widget)),
        icon: Icon(icon, size: 28),
        color: const Color(0xffd0d0d0),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xff111111),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              _locationImagePath,
              fit: BoxFit.cover,
              width: 28,
              height: 28,
            ),
          ),
          const SizedBox(width: 8),
          Text(_locationName, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  void _dialogToggleFunc(bool flag) {
    setState(() {
      _isBottomDialogVisible = flag;
    });
  }

  void _updateSheetSize(double size) {
    setState(() {
      _currentSheetSize = size;
    });
  }
}
