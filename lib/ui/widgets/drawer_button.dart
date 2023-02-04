import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onPressed;
  const DrawerButton({
    Key? key,
    required this.label,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: isSelected ? Colors.blue : Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
