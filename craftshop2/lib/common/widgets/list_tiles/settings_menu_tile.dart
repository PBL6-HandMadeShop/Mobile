import 'package:flutter/material.dart';

class TSettingsMenuTile extends StatelessWidget{
  const TSettingsMenuTile({super.key, required this.icon, required this.title, required this.subTitle, this.trailing, this.onTab});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size:28, color: TColor.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: trailing,
      onTap: onTab,
    );
  }
}