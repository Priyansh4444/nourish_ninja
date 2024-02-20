import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import '../../../constants.dart';
import './sign_in.dart';    

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Register Account", style: headingStyle),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignInForm(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    const Text("Or continue with"),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired page
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: Text(
                      'Already have an account? Sign In',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                  
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // Added Expanded widget
                        flex: 8, // Set flex value to 8
                        child: ElevatedButton(
                          onPressed: () async {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
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
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
