import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arvyax_application/data/models/ambience_model.dart';
import 'player_controller.dart';
import '../journal/journal_screen.dart';

class SessionPlayerScreen extends StatefulWidget {
  final Ambience ambience;

  const SessionPlayerScreen({super.key, required this.ambience});

  @override
  State<SessionPlayerScreen> createState() =>
      _SessionPlayerScreenState();
}

class _SessionPlayerScreenState extends State<SessionPlayerScreen> {
  late Timer timer;
  int elapsed = 0;

  @override
  void initState() {
    super.initState();

    final player = context.read<PlayerController>();
    player.play(widget.ambience.audio);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed++;

      if (elapsed >= widget.ambience.duration) {
        endSession();
      }

      setState(() {});
    });
  }

  void endSession() {
    timer.cancel();
    context.read<PlayerController>().stop();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerController>();

    return Scaffold(
      body: Stack(
        children: [
          /// 🌄 BACKGROUND IMAGE
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              widget.ambience.image,
              fit: BoxFit.cover,
            ),
          ),

          /// 🌑 DARK OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.5),
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
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          /// 🎧 PLAYER UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// 🎵 TITLE
              Text(
                widget.ambience.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// 🏷 TAG
              Text(
                widget.ambience.tag,
                style: const TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 40),

              /// 🎚 SLIDER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Slider(
                      value: elapsed.toDouble(),
                      max: widget.ambience.duration.toDouble(),
                      activeColor: Colors.deepPurple,
                      onChanged: (v) {
                        setState(() {
                          elapsed = v.toInt();
                        });

                        player.seek(Duration(seconds: v.toInt()));
                      },
                    ),

                    /// ⏱ TIME
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(elapsed),
                            style: const TextStyle(
                                color: Colors.white70)),
                        Text(
                            formatTime(widget.ambience.duration),
                            style: const TextStyle(
                                color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ▶️ PLAY / PAUSE BUTTON
              GestureDetector(
                onTap: () {
                  if (player.isPlaying) {
                    player.pause();
                  } else {
                    player.resume();
                  }
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    player.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ⛔ END BUTTON
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("End Session?"),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: endSession,
                          child: const Text("End"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "End Session",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}