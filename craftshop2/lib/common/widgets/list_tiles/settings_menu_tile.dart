import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CSSettingsMenuTile extends StatelessWidget{
  const CSSettingsMenuTile({super.key, required this.icon, required this.title, required this.subTitle, this.trailing, this.onTab});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size:28, color: CSColors.primaryColor),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTab,
    );
  }
}