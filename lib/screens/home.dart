import 'package:ai_art_generator/constants/index.dart';
import 'package:ai_art_generator/items/category_button.dart';
import 'package:ai_art_generator/items/art_item.dart';
import 'package:ai_art_generator/models/art_data_model.dart';
import 'package:ai_art_generator/provider/auth_service.dart';
import 'package:ai_art_generator/screens/detail.dart';
import 'package:ai_art_generator/screens/generated.dart';
import 'package:ai_art_generator/widgets/art_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();

  String? imagineInput;

  String imageUrl = "";
  bool loading = false;

  bool isMine = false;

  bool isFActive = true;
  bool isHActive = false;
  bool isIActive = false;
  bool isPActive = false;

  bool isLoggedIn = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0XFF080B16),
        backgroundColor: secondaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Ai Art Generator",
                          style: TextStyle(
                              color: normalWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.account_circle_outlined,
                                color: primaryColor,
                                size: 30,
                              )))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: FormInputDecoration("imagine here..."),
                    onChanged: (value) => {imagineInput = value},
                    onSubmitted: (value) => {imagineInput = value},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isActive: isMine,
                          categoryTitle: "Mine",
                          onPress: () {
                            setState(() {
                              isMine = true;
                              isFActive = false;
                              isHActive = false;
                              isIActive = false;
                              isPActive = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isActive: isFActive,
                          categoryTitle: "Futuristic",
                          onPress: () {
                            setState(() {
                              isMine = false;
                              isFActive = true;
                              isHActive = false;
                              isIActive = false;
                              isPActive = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isActive: isHActive,
                          categoryTitle: "History",
                          onPress: () {
                            setState(() {
                              isMine = false;
                              isFActive = false;
                              isHActive = true;
                              isIActive = false;
                              isPActive = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isActive: isIActive,
                          categoryTitle: "Imaginary",
                          onPress: () {
                            setState(() {
                              isMine = false;
                              isFActive = false;
                              isHActive = false;
                              isIActive = true;
                              isPActive = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryButton(
                          isActive: isPActive,
                          categoryTitle: "Persons",
                          onPress: () {
                            setState(() {
                              isMine = false;
                              isFActive = false;
                              isHActive = false;
                              isIActive = false;
                              isPActive = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isFActive
                    ? ArtWidget(
                        givenList: futureArtList,
                      )
                    : isHActive
                        ? ArtWidget(
                            givenList: historyArtList,
                          )
                        : isIActive
                            ? ArtWidget(
                                givenList: imaginaryArtList,
                              )
                            : isPActive
                                ? ArtWidget(
                                    givenList: personArtList,
                                  )
                                : isMine && imageUrl != ""
                                    ? ArtWidget(givenList: [
                                        ArtDataModel(
                                          image: imageUrl,
                                          title: imagineInput!,
                                        ),
                                      ])
                                    : isMine
                                        ? AuthService().handleAuthState()
                                        : Text("none")
              ],
            ),
          ),
        ),
      ),
    );
  }

  // login widget
  // Padding loginWidget() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
  //     child: Center(
  //       child: Column(
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               print("heyy there");
  //               final provider =
  //                   Provider.of<GoogleSignInProvider>(context, listen: false);
  //               provider.googleLogin();
  //             },
  //             child: SocialItem(
  //               socialIcon: "assets/images/google.png",
  //               socialTitle: "continue with Google",
  //               onPress: () {},
  //             ),
  //           ),
  //           SocialItem(
  //             socialIcon: "assets/images/facebook.png",
  //             socialTitle: "continue with Facebook",
  //             onPress: () {
  //               print("heyy");
  //             },
  //           ),
  //           SocialItem(
  //             socialIcon: "assets/images/instagram.png",
  //             socialTitle: "continue with Instagram",
  //             onPress: () {},
  //           ),
  //           SizedBox(
  //             height: 50,
  //           ),
  //           Text(
  //             "Login to save images you generated",
  //             style: TextStyle(color: normalWhite),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  SizedBox mineWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: InkWell(
        onTap: () {},
        child: Material(
          elevation: 5,
          shadowColor: primaryColor,
          color: Colors.transparent,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Lottie.asset("assets/lottie/img-placeholder2.json",
                  animate: true)),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  InputDecoration FormInputDecoration(String hint) {
    return InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white.withOpacity(0.5),
          size: 25,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.20), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        contentPadding: const EdgeInsets.all(1),
        filled: true,
        fillColor: secondaryLightDark,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeneratedScreen(
                            title: imagineInput,
                          )));
            },
            child: const Text("Go")));
  }
}
