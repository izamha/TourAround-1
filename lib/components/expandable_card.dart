import 'package:flutter/material.dart';


class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    Key? key,
    required this.isExpanded,
    required this.collapsedChild,
    required this.expandedChild,
  }) : super(key: key);

  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
    );
  }
}
