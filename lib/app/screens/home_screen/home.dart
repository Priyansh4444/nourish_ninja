// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/screens/home_screen/components/goal_card.dart';

import 'components/track_your_progress.dart';
import 'components/widge_shop.dart';
import 'components/footer_icons.dart';
// import other components as needed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Set the theme to dark theme
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: TrackYourProgress(),
                ),
                SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: const [
                //     RoundedShopWidget(),
                //     // add other components here
                //   ],
                // ),
                SizedBox(height: 20),
                // add other components here
              ],
            ),
          ),
        ),
        bottomNavigationBar: const FooterIcons(),
      ),
    );
  }
}