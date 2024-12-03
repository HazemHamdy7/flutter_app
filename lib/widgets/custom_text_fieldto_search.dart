// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFieldtoSearch extends StatelessWidget {
  void Function(String)? onChanged;
  CustomTextFieldtoSearch({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        labelText: ' ${S.of(context).search} ..... ',
        labelStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
        fillColor: isDark ? Colors.grey[500] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
