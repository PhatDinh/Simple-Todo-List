import 'package:flutter/material.dart';

class RoundedTabText extends StatelessWidget {
  final String nameTab;
  final Function onPress;
  const RoundedTabText({
    required this.nameTab,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () => onPress,
        child: Text(
          nameTab,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
