import 'package:flutter/material.dart';

class AnimatedPageIndicatorFb1 extends StatelessWidget {
  const AnimatedPageIndicatorFb1({
    super.key,
    required this.currentPage,
    required this.numPages,
    this.dotHeight = 10,
    this.activeDotHeight = 20,
    this.dotWidth = 10,
    this.activeDotWidth = 20,
    this.color = Colors.white,
    this.activeColor = const Color(0xff1E70AD),
  });

  final int currentPage;
  final int numPages;

  final double dotWidth;
  final double activeDotWidth;
  final double activeDotHeight;
  final double dotHeight;
  final Color color;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .30,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          numPages,
          (index) => AnimatedPageIndicatorDot(
            isActive: currentPage == index,
            color: color,
            activeColor: activeColor,
            activeWidth: activeDotWidth,
            activeHeight: activeDotHeight,
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicatorDot extends StatelessWidget {
  const AnimatedPageIndicatorDot({
    super.key,
    required this.isActive,
    this.height = 20,
    this.width = 20,
    this.activeWidth = 40,
    this.activeHeight = 40,
    required this.color,
    required this.activeColor,
  });

  final bool isActive;
  final double height;
  final double width;
  final double activeWidth;
  final double activeHeight;
  final Color color;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isActive ? activeWidth : width,
      height: isActive ? activeHeight : height,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? activeColor : color,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff1E70AD)),
      ),
    );
  }
}
