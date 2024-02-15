import 'package:flutter/material.dart';

class TrackYourProgress extends StatelessWidget {
  const TrackYourProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0), // Add padding around the box
        width: MediaQuery.of(context).size.width * 0.7, // Set the width to 70% of the screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [Colors.black, Colors.green],
            stops: const [0.3, 0.7],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Track Your Progress',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.lightGreen, // Change the button color to a lighter green
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                    topLeft: Radius.circular(13), // Make the diagonal sharp
                    bottomLeft: Radius.circular(13), // Make the diagonal sharp
                  ),
                ), // Add padding around the button
                  child: TextButton(
                    onPressed: () {
                      // Add your logic here
                    },
                    child: Text(
                      'View Now',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}