import 'package:flutter/material.dart';
import '../utils/audio_service.dart';

/// Simple wrappers that play a short click SFX before invoking the provided
/// callback. These are intentionally small so they can replace standard
/// `ElevatedButton`, `OutlinedButton`, and `IconButton` usages.

class SfxElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const SfxElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  void _handlePress() {
    AudioService.instance.playSfx('click.wav', volume: 0.6);
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed == null ? null : _handlePress,
      style: style,
      child: child,
    );
  }
}

class SfxOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const SfxOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  void _handlePress() {
    AudioService.instance.playSfx('click.wav', volume: 0.6);
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed == null ? null : _handlePress,
      style: style,
      child: child,
    );
  }
}

class SfxIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;

  const SfxIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  void _handlePress() {
    AudioService.instance.playSfx('click.wav', volume: 0.6);
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed == null ? null : _handlePress,
      icon: icon,
      tooltip: tooltip,
    );
  }
}
