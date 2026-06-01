import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioService {
  AudioService._internal();
  static final AudioService instance = AudioService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();
  bool _bgmPlaying = false;
  String? _currentBgmAssetPath;

  Future<void> startBgmLoop({
    String assetPath = 'sounds/bgm_loop.mp3',
    double volume = 0.3,
  }) async {
    await playLoopingSound(assetPath, volume: volume);
  }

  Future<void> playLoopingSound(String fileName, {double volume = 0.3}) async {
    try {
      final assetPath = fileName.startsWith('sounds/')
          ? fileName
          : 'sounds/$fileName';
      if (_bgmPlaying && _currentBgmAssetPath == assetPath) {
        return;
      }
      if (_bgmPlaying) {
        await _bgmPlayer.stop();
        _bgmPlaying = false;
      }
      final data = await rootBundle.load('assets/$assetPath');
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(volume);
      await _bgmPlayer.play(BytesSource(data.buffer.asUint8List()));
      _bgmPlaying = true;
      _currentBgmAssetPath = assetPath;
    } catch (e) {
      debugPrint('AudioService.playLoopingSound($fileName) error: $e');
    }
  }

  Future<void> stopBgm() async {
    try {
      await _bgmPlayer.stop();
      _bgmPlaying = false;
      _currentBgmAssetPath = null;
    } catch (e) {
      debugPrint('AudioService.stopBgm error: $e');
    }
  }

  Future<void> playSfx(String fileName, {double volume = 1.0}) async {
    try {
      // Try loading asset bytes and play from memory (more reliable cross-platform).
      debugPrint('AudioService: loading bytes for $fileName');
      final data = await rootBundle.load('assets/sounds/$fileName');
      final bytes = data.buffer.asUint8List();
      final player = AudioPlayer();
      await player.setVolume(volume);
      await player.play(BytesSource(bytes));
      // Dispose after a short delay to ensure the sound finishes and player is released.
      Future.delayed(const Duration(seconds: 1), () async {
        try {
          await player.stop();
          await player.dispose();
          debugPrint('AudioService: disposed sfx player for $fileName');
        } catch (_) {}
      });
    } catch (e) {
      debugPrint('AudioService.playSfx($fileName) error: $e');
      debugPrint('AudioService: fallback to AssetSource for $fileName');
      try {
        final player = AudioPlayer();
        await player.setVolume(volume);
        await player.play(AssetSource('sounds/$fileName'));
        Future.delayed(const Duration(seconds: 1), () async {
          try {
            await player.stop();
            await player.dispose();
          } catch (_) {}
        });
      } catch (e2) {
        debugPrint('AudioService.playSfx fallback failed: $e2');
      }
    }
  }

  Future<void> dispose() async {
    try {
      await _bgmPlayer.dispose();
      await _sfxPlayer.dispose();
    } catch (e) {
      debugPrint('AudioService.dispose error: $e');
    }
  }
}
