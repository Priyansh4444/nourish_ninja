import 'package:flutter/material.dart';

import 'components/track_your_progress.dart';
import 'components/widge_shop.dart';
import 'components/footer_icons.dart';
// import other components as needed

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: TrackYourProgress(),
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: const [
            //     RoundedShopWidget(),
            //     // add other components here
            //   ],
            // ),
            const SizedBox(height: 20),
            // add other components here
          ],
        ),
      ),
      bottomNavigationBar: FooterIcons(),
    );
  }
}