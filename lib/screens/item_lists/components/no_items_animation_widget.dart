import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class NoItemsAnimationWidget extends StatelessWidget {
  final String message;
  const NoItemsAnimationWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          'assets/lotties/empty_box.json',
          height: 200,
        ),
        const SizedBox(height: 20),
        Center(child: Text(message)),
      ],
    );
  }
}
