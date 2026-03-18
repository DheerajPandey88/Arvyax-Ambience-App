import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'player_controller.dart';

class MiniPlayer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerController>();

  
    if (!player.isPlaying && player.position.inSeconds == 0) {
      return const SizedBox();
    }

    double progress = 0;
    if (player.total.inSeconds > 0) {
      progress =
          player.position.inSeconds / player.total.inSeconds;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[900]?.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [
            /// 🎵 ICON
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.music_note,
                  color: Colors.white),
            ),

            const SizedBox(width: 10),

            /// 🎧 TITLE + PROGRESS
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white10,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),

            /// ▶️ PLAY / PAUSE
            IconButton(
              icon: Icon(
                player.isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                if (player.isPlaying) {
                  player.pause();
                } else {
                  player.resume(); // ✅ FIXED
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}