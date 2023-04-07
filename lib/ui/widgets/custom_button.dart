import 'package:flutter/material.dart';

import 'custom_card.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final IconData? icon;
  final Color? buttonColor, iconColor, labelColor;
  final double elevation;
  final bool isLoading;
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.buttonColor,
    this.iconColor,
    this.labelColor,
    this.elevation = 0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: buttonColor ?? Colors.white,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: icon != null ? 10 : 20,
            top: 12.5,
            bottom: 12.5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: icon != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: isLoading
                ? [
                    SizedBox(
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: LinearProgressIndicator(
                          color: labelColor,
                          backgroundColor: labelColor?.withOpacity(.2),
                        ),
                      ),
                    )
                  ]
                : [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: labelColor,
                          ),
                    ),
                    SizedBox(
                      width: icon != null ? 5 : 0,
                    ),
                    icon != null
                        ? Icon(
                            icon!,
                            color: iconColor,
                            size: 20,
                          )
                        : const SizedBox()
                  ],
          ),
        ),
      ),
    );
  }
}
