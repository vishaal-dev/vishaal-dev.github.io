import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  
  const AnimatedText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int charCount = (widget.text.length * _animation.value).round();
        final String visibleText = widget.text.substring(0, charCount);
        
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              visibleText,
              style: widget.style,
            ),
            if (charCount < widget.text.length)
              AnimatedOpacity(
                opacity: 1.0 - (_animation.value * 2 % 1),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  '|',
                  style: widget.style,
                ),
              ),
          ],
        );
      },
    );
  }
}
