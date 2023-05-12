import 'package:flutter/material.dart';

class MyLoadingButton extends StatelessWidget {
  VoidCallback _onPressed = () {};
  Widget? _title;
  double? _thickness;
  bool? _loading;
  double _sizeProgress = 0;
  Color? _colorBackground;

  MyLoadingButton({
    Key? key,
    required VoidCallback onPressed,
    required Widget title,
    double? thickness,
    bool? loading,
    double? sizeProgress,
    Color? colorBackground,
  }) : super(key: key) {
    _onPressed = onPressed;
    _colorBackground = colorBackground;
    _title = title;
    _thickness = thickness;
    _loading = loading;
    _sizeProgress = sizeProgress ?? 15;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPressed(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_thickness ?? 20.0)),
        backgroundColor: _colorBackground ?? Theme.of(context).primaryColor,
      ),
      child: _loading == true
          ? SizedBox(
              height: _sizeProgress,
              width: _sizeProgress,
              child: const CircularProgressIndicator(),
            )
          : _title,
    );
  }
}
