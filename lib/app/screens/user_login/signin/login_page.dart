import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';

import 'no_account_text.dart';
import 'login.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/login";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized");
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change color to white
          ),
        ),
        backgroundColor: NourishNinjaTheme.background,
      ),
      backgroundColor: NourishNinjaTheme.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: const SizedBox(height: 16),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white, // Change color to white
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const Text(
                      "Sign in with your email and password  \nor continue with social media",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white, // Change color to white
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const SizedBox(height: 16),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: NourishNinjaTheme.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const SignForm(),
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const SizedBox(height: 16),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: ElevatedButton(
                            onPressed: () {
                              signInWithGoogle().then((userCredential) {
                                Navigator.pushNamed(context, Stats.routeName);
                              }).catchError((error) {
                                print(
                                    "Error occurred while signing in with Google: $error");
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: NourishNinjaTheme.darkText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/_Google.svg",
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Google",
                                  style: TextStyle(
                                    color: Colors.white, // Change color to black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const SizedBox(height: 20),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const NoAccountText(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
