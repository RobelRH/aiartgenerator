import 'package:ai_art_generator/constants/index.dart';
import 'package:flutter/material.dart';

class ArtItem extends StatelessWidget {
  const ArtItem(
      {Key? key,
      required this.imageUrl,
      required this.imageTitle,
      required this.onTap})
      : super(key: key);

  final String imageUrl;
  final String imageTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        shadowColor: primaryColor,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 1,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           fit: BoxFit.cover,
    //           image: NetworkImage(
    //             imageUrl,
    //             //   loadingBuilder: (BuildContext context, Widget child,
    //             //       ImageChunkEvent? loadingProgress) {
    //             //     if (loadingProgress == null) return child;
    //             //     return Center(
    //             //       child: CircularProgressIndicator(
    //             //         value: loadingProgress.expectedTotalBytes != null
    //             //             ? loadingProgress.cumulativeBytesLoaded /
    //             //                 loadingProgress.expectedTotalBytes!
    //             //             : null,
    //             //       ),
    //             //     );
    //             //   },
    //           ))),
    // );
  }
}
