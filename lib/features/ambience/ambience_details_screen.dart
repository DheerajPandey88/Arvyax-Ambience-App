import 'package:flutter/material.dart';
import 'package:arvyax_application/features/ambience/player/session_player_screen.dart';
import '../../data/models/ambience_model.dart';

class AmbienceDetailsScreen extends StatelessWidget {
  final Ambience ambience;

  const AmbienceDetailsScreen({super.key, required this.ambience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌄 BACKGROUND IMAGE
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              ambience.image,
              fit: BoxFit.cover,
            ),
          ),

          /// 🌑 DARK OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          /// 🔙 BACK BUTTON
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          /// 📄 CONTENT
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.black87,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🎵 TITLE
                  Text(
                    ambience.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  /// 🏷 TAG + DURATION
                  Text(
                    "${ambience.tag} • ${ambience.duration}s",
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 15),

                  /// 📖 DESCRIPTION
                  Text(
                    ambience.description,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 15),

                  /// 🎯 SENSORY TAGS
                  Wrap(
                    spacing: 8,
                    children: ambience.sensory
                        .map((s) => Chip(
                              backgroundColor: Colors.white10,
                              label: Text(
                                s,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 25),

                  /// ▶️ PLAY BUTTON (MAIN)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Start Session"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SessionPlayerScreen(ambience: ambience),
                          ),
                        );
                      },
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