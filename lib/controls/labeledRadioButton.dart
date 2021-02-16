import 'package:flutter/material.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final T groupValue;
  final T value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            groupValue: groupValue,
            value: value,
            onChanged: (T newValue) {
              onChanged(newValue);
            },
          ),
          Text(label),
        ],
      ),
    );
  }
}
