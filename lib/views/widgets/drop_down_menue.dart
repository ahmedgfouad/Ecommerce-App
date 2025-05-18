import 'package:flutter/material.dart';

class DropDownMenuComponant extends StatelessWidget {
  const DropDownMenuComponant({
    super.key,
    required this.onChanged,
    required this.items, required this.hint,
  });
  final void Function(String?) onChanged;
  final List<String> items;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down),
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      hint: Text(hint),
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      items:
          items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
