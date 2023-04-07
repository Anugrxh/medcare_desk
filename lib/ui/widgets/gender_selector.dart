import 'package:flutter/material.dart';

import 'custom_radio_button.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onSelect;
  final String selected;
  const GenderSelector({
    super.key,
    required this.onSelect,
    this.selected = 'male',
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomRadioButton(
            onPressed: () {
              widget.onSelect('male');
              _selected = 'male';
              setState(() {});
            },
            label: 'Male',
            isSelected: _selected == 'male',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomRadioButton(
            onPressed: () {
              widget.onSelect('female');
              _selected = 'female';
              setState(() {});
            },
            label: 'Female',
            isSelected: _selected == 'female',
          ),
        ),
      ],
    );
  }
}
