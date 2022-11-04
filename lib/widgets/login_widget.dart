import 'package:ai_art_generator/items/social_item.dart';
import 'package:ai_art_generator/provider/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Center(
        child: Column(
          children: [
            SocialItem(
              socialIcon: "assets/images/google.png",
              socialTitle: "continue with Google",
              onPress: () {
                print("jey");
                AuthService().signInWithGoogle();
              },
            ),
            SocialItem(
              socialIcon: "assets/images/facebook.png",
              socialTitle: "continue with Facebook",
              onPress: () {
                print("heyy");
              },
            ),
            SocialItem(
              socialIcon: "assets/images/instagram.png",
              socialTitle: "continue with Instagram",
              onPress: () {},
            ),
            ElevatedButton(
                onPressed: () {
                  // FirebaseFirestore.instance.collection('imagedata').add({
                  //   'email': 'app@gmail.com',
                  //   'imageUrl': [
                  //     'https://miro.medium.com/max/828/1*ucMdnWqiVWxJYlaIacjjjw.jpeg'
                  //   ]
                  // });
                  var abc = FirebaseFirestore.instance
                      .collection('imagedata')
                      .get()
                      .then((value) {
                    print("abc is: ${value.docs[0].data()["email"]}");
                    for (var i = 0; i < value.size; i++) {
                      var gEmail = value.docs[i].data()["email"];
                      if (gEmail == "app@gmail.com") {
                        print(gEmail);
                      }
                    }
                  });
                },
                child: Text("test add data"))
          ],
        ),
      ),
    );
  }
}
