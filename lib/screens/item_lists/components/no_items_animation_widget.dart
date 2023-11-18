import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoItemsAnimationWidget extends StatelessWidget {
  final String message;
  final String animationFile;
  const NoItemsAnimationWidget({super.key, required this.message, required this.animationFile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Centered Layout
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                animationFile,
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(message),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),

        // Scrollable overlay
        Positioned.fill(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(),
          ),
        ),
      ],
    );
  }
}
