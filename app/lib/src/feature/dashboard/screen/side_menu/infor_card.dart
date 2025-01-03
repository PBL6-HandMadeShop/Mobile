import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, required this.level,
  });
  final String name, level;
  @override
  Widget build(BuildContext context) {
    return ListTile(leading:const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person,
            color: Colors.white)),
      title: Text(name, style:const TextStyle(color: Colors.white)),
      subtitle: Text(level, style:const TextStyle(color: Colors.white)),
    );
  }
}