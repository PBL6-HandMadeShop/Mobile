import 'package:flutter/material.dart';

import 'curved_edges.dart';

class CSCurvedEdgeWidget extends StatelessWidget {
  const CSCurvedEdgeWidget({
    this.child,
    super.key,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CSCustomCurvedEgdes(),
      child: child,
    );
  }
}