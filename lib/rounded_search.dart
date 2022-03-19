import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedSearchField extends StatelessWidget {
  final String hintText;
  final IconData hintIcon;
  final ValueChanged<String> onChanged;
  const RoundedSearchField({
    Key? key,
    required this.hintText,
    this.hintIcon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      child: Container(
        width: size.width * 0.7,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              icon: Icon(hintIcon)),
        ),
      ),
    );
  }
}
