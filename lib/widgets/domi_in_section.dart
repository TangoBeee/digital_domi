import 'package:flutter/material.dart';

class DomiInSection extends StatelessWidget {
  final List<String> imagePath;

  const DomiInSection({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader("dōmi in", () {}),
              const SizedBox(height: 8),
              _buildImageScroll(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerRight,
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
          ),
          child: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildImageScroll() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(imagePath.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index == imagePath.length - 1 ? 0 : 9.0),
              child: SizedBox(
                width: 75,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(imagePath[index], fit: BoxFit.cover),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}