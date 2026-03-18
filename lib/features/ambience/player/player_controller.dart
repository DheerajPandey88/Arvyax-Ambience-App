import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerController extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  Duration position = Duration.zero;
  Duration total = Duration.zero;
  bool isPlaying = false;

  String currentPath = "";

  PlayerController() {
    /// 🎧 LISTEN POSITION
    player.onPositionChanged.listen((p) {
      position = p;
      notifyListeners();
    });

    /// ⏱ TOTAL DURATION
    player.onDurationChanged.listen((d) {
      total = d;
      notifyListeners();
    });

    /// 🔚 COMPLETE
    player.onPlayerComplete.listen((event) {
      isPlaying = false;
      position = Duration.zero;
      notifyListeners();
    });
  }

  /// ▶️ PLAY AUDIO
  Future<void> play(String path) async {
    currentPath = path;

    await player.stop(); // reset previous
    await player.setReleaseMode(ReleaseMode.loop);

    await player.play(AssetSource(path));

    isPlaying = true;
    notifyListeners();
  }

  /// ⏸ PAUSE
  Future<void> pause() async {
    await player.pause();
    isPlaying = false;
    notifyListeners();
  }

  /// ▶️ RESUME (FIXED)
  Future<void> resume() async {
    await player.resume();
    isPlaying = true;
    notifyListeners();
  }

  /// ⏹ STOP
  Future<void> stop() async {
    await player.stop();
    isPlaying = false;
    position = Duration.zero;
    notifyListeners();
  }

  /// ⏩ SEEK (NEW FEATURE 🔥)
  Future<void> seek(Duration newPosition) async {
    await player.seek(newPosition);
  }
}