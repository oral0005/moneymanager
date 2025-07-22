import 'package:flutter/material.dart';
import '../theme/style_constants.dart';

class StyledListTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const StyledListTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0), // 
      leading: Icon(
        icon,
        color: kListTileIconColor,
        size: kListTileIconSize,
      ),
      title: Text(title, style: kListTileTextStyle),
      onTap: () {}, // Optional: add navigation or logic
    );
  }
}
