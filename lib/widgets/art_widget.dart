import 'package:ai_art_generator/items/art_item.dart';
import 'package:ai_art_generator/models/art_data_model.dart';
import 'package:ai_art_generator/screens/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtWidget extends StatelessWidget {
  const ArtWidget({
    Key? key,
    required this.givenList,
  }) : super(key: key);

  final List<ArtDataModel> givenList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.7,
        children: List.generate(givenList.length, (index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ArtItem(
                imageUrl: givenList[index].image,
                imageTitle: givenList[index].title,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Details(artDataModel: givenList[index])));
                },
              ));
        }),
      ),
    );
  }
}
