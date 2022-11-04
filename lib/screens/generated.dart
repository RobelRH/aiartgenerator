import 'package:ai_art_generator/apiservices/artservice.dart';
import 'package:ai_art_generator/constants/index.dart';
import 'package:ai_art_generator/models/art_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';

class GeneratedScreen extends StatefulWidget {
  const GeneratedScreen({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<GeneratedScreen> createState() => _GeneratedScreenState();
}

class _GeneratedScreenState extends State<GeneratedScreen> {
  String imageUrl = "";

  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("from generated-------------------- ${widget.title}");
    ArtRequestModel artRequestModel = ArtRequestModel(prompt: widget.title);
    ArtService.requestPrompt(artRequestModel).then((value) {
      setState(() {
        imageUrl = value.generated!;
      });
      print("value is ${value.generated}");
    }).catchError((error) {
      print("error is: $error");
    });

    if (!isLoggedIn) {
      FirebaseFirestore.instance.collection('imagedata').add({
        'email': FirebaseAuth.instance.currentUser!.email,
        'imageUrl': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEBx9Wr0-Vrvo7-X_EwAXnCxBrBODj3sjPLE_6DZPA&s'
        ],
        'title': ""
      });
    }
  }

  _save() async {
    var response = await Dio().get(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: normalWhite.withOpacity(0.8),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              imageUrl == ""
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child:
                          Lottie.asset("assets/lottie/anim-placeholder.json"))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.6,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.6,
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  imageUrl != ""
                      ? widget.title!
                      : "YOUR IMAGE WILL BE GENERATED SOON",
                  style: TextStyle(
                    wordSpacing: 1,
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 17,
                  ),
                ),
              ),
              imageUrl != ""
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: InkWell(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              secondaryLight)),
                                  onPressed: () {},
                                  child: const Icon(Icons.share)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        secondaryLight)),
                                onPressed: () {
                                  _save();
                                },
                                child: const Icon(Icons.download)),
                          ),
                          !isLoggedIn
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  secondaryLight)),
                                      onPressed: () {},
                                      child: const Icon(Icons.delete)),
                                )
                              : const Text("")
                        ],
                      ),
                    )
                  : const Text("data")
            ],
          ),
        ),
      ),
    );
  }
}
