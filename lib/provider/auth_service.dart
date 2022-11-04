import 'package:ai_art_generator/constants/index.dart';
import 'package:ai_art_generator/items/art_item.dart';
import 'package:ai_art_generator/models/art_data_model.dart';
import 'package:ai_art_generator/widgets/art_widget.dart';
import 'package:ai_art_generator/widgets/login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Determine if the user is authenticated.
  handleAuthState() {
    // List<ArtDataModel> generatedImageList = [
    //   ArtDataModel(
    //     image:
    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEBx9Wr0-Vrvo7-X_EwAXnCxBrBODj3sjPLE_6DZPA&s",
    //     title:
    //         "aerial view of a giant fish tank shaped like a tower in the middle of new york city, 8k octane render, photorealistic",
    //   ),
    //   ArtDataModel(
    //     image: "http://newkjld.png",
    //     title:
    //         "full body portrait of a small child, cyberpunk, in the background a gigantic gundam in a blurred city scene, artstation, 8k, octane render, unreal engine, very detailed, concept art, realistic, masterpiece, sharp, rule of thirds ,",
    //   ),
    //   ArtDataModel(image: "http://kljhlk.png", title: "title")
    // ];

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                // ArtWidget(givenList: generatedImageList),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: TextStyle(color: normalWhite),
                ),
                ElevatedButton(
                    onPressed: () {
                      AuthService().signOut();
                    },
                    child: Text("log out")),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      // FirebaseFirestore.instance.collection('imagedata').add({
                      //   'email': FirebaseAuth.instance.currentUser!.email,
                      //   'imageUrl': [
                      //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEBx9Wr0-Vrvo7-X_EwAXnCxBrBODj3sjPLE_6DZPA&s'
                      //   ],
                      //   'title': ""
                      // });
                      // FirebaseFirestore.instance
                      //     .collection('imagedata')
                      //     .get()
                      //     .then((value) {
                      //   for (var i = 0; i < value.size; i++) {
                      //     var getEmail = value.docs[i].data()["email"];
                      //     var getImageUrl = value.docs[i].data()["imageUrl"];

                      //     if (getEmail ==
                      //         FirebaseAuth.instance.currentUser!.email) {
                      //       // FirebaseFirestore.instance
                      //       //     .collection("imagedata")
                      //       //     .doc(value.docs[i].id)
                      //       //     .update({
                      //       //   "imageUrl":
                      //       //       FieldValue.arrayUnion(["http://kljhlk.png"])
                      //       // });
                      //       print("image url: ${getImageUrl}");
                      //     }
                      //   }
                      // });
                    },
                    child: Text("add data"))
              ],
            );
          } else {
            return LoginWidget();
          }
        });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
