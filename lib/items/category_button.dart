import 'package:ai_art_generator/constants/index.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {Key? key,
      required this.isActive,
      required this.categoryTitle,
      required this.onPress})
      : super(key: key);

  final bool isActive;
  final String categoryTitle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: isActive
                ? MaterialStateProperty.all(secondaryLight)
                : MaterialStateProperty.all(normalWhite.withOpacity(0.15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
        onPressed: onPress,
        child: Text(
          categoryTitle,
          style: TextStyle(color: isActive ? normalWhite : normalWhite),
        ));
  }
}
