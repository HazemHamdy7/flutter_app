import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;
  final bool isHeader;
  Color? color;
  final void Function()? onTap;

  CustomListTile({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.color,
    this.onTap,
    this.isHeader = false, // Default value for isHeader
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.blue) : null,
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: isHeader ? 14 : 16,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: trailing,
        onTap: () {
          // Handle navigation or actions
        },
      ),
    );
  }
}
