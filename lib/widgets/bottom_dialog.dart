import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BottomDialog extends StatelessWidget {
  final ValueChanged<bool> dialogToggleFunc;
  const BottomDialog({required this.dialogToggleFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Invite & Earn",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    dialogToggleFunc(false);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Text(
              "Invite your neighbor and you both receive \$10 when they claim their address.",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Share.share('vibe vro vibe\nhttps://www.youtube.com/watch?v=hxhvYiYxvMo');
                  },
                  child: const Text(
                    "Send invite",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
