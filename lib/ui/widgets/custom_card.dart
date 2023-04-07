import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final Function()? onPressed;

  const CustomCard({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.white,
    this.borderRadius = 10,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovering = true),
        onExit: (event) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.color,
            boxShadow: _isHovering
                ? []
                : [
                    const BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 3,
                    )
                  ],
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
