import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const LottieAnimation({
    required this.asset,
    this.height,
    this.fit,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.addStatusListener((status) async {});
  }

  @override
  void dispose() {
    controller.removeStatusListener((status) {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      widget.asset,
      controller: controller,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      onLoaded: (composition) {
        controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
