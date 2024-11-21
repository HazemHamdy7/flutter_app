 import 'package:flutter/material.dart';

import 'package:flutter_app/generated/l10n.dart';

class CustomTextFieldtoSearch extends StatelessWidget {
  void Function(String)? onChanged;
  CustomTextFieldtoSearch({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        labelText: ' ${S.of(context).search} ..... ',
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
