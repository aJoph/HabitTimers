import 'package:flutter/material.dart';

class TwinButton extends StatelessWidget {
  final VoidCallback onPressed1st;
  final VoidCallback onPressed2nd;
  final Widget childOne;
  final Widget childTwo;
  final double size;
  const TwinButton({
    super.key,
    required this.childOne,
    required this.childTwo,
    required this.onPressed1st,
    required this.onPressed2nd,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size * 0.4,
          child: ElevatedButton(
            onPressed: onPressed1st,
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(24)),
                ),
              ),
            ),
            child: const Text("Stop"),
          ),
        ),
        SizedBox(
          width: size,
          height: size * 0.4,
          child: ElevatedButton(
            onPressed: onPressed2nd,
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(24)),
                ),
              ),
            ),
            child: const Text("Pause"),
          ),
        ),
      ],
    );
  }
}
