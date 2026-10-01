import 'package:flutter/material.dart';

class AsyncTextButton extends StatefulWidget {
  const AsyncTextButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Future<void> Function() onPressed;
  final Widget child;

  @override
  State<AsyncTextButton> createState() => _AsyncTextButtonState();
}

class _AsyncTextButtonState extends State<AsyncTextButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isLoading ? null : _handlePress,
      child: widget.child,
    );
  }
}