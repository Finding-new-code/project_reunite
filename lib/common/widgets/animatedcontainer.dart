// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AnimatedGradientBorderContainer extends StatefulWidget {
  const AnimatedGradientBorderContainer({super.key});

  @override
  _AnimatedGradientBorderContainerState createState() =>
      _AnimatedGradientBorderContainerState();
}

class _AnimatedGradientBorderContainerState
    extends State<AnimatedGradientBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(_animation.value),
            Colors.green.withOpacity(_animation.value),
          ],
        ),
        border: Border.all(
          color: Colors.yellow.withOpacity(_animation.value),
          width: 4.0,
        ),
      ),
      child: Container(
          // Content of your container goes here
          ),
    );
  }
}

class AnimatedStackContainer extends StatefulWidget {
  final double width;
  final double height;
  final Widget children;
  const AnimatedStackContainer({super.key, required this.width, required this.height,required this.children});

  @override
  _AnimatedStackContainerState createState() => _AnimatedStackContainerState();
}

class _AnimatedStackContainerState extends State<AnimatedStackContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: <Widget>[
        AnimatedContainer(
          height: widget.height,
          width: widget.width,
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withOpacity(_animation.value),
                Colors.green.withOpacity(_animation.value),
              ],
            ),
            // border: Border.all(
            //   color: Colors.yellow.withOpacity(_animation.value),
            //   width: 4.0,
            // ),
          ),

          // Content of your container goes here
        ),
        Container(
          height: widget.height - 4,
          width: widget.width - 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
          color: Colors.black),
          child: Column(children: [
            widget.children
          ]),
        )
      ],
    );
  }
}
