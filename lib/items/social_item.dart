import 'package:ai_art_generator/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialItem extends StatelessWidget {
  const SocialItem(
      {super.key,
      required this.socialIcon,
      required this.socialTitle,
      required this.onPress});

  final String socialIcon;
  final String socialTitle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(normalWhite)),
          onPressed: onPress,
          label: Text(
            socialTitle,
            style: const TextStyle(color: normalBlack),
          ),
          icon: const Icon(
            FontAwesomeIcons.facebook,
            color: Colors.blue,
          ),
        ));
  }
}
