// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RoundedShopWidget extends StatelessWidget {
  final int notificationCount;

  const RoundedShopWidget({Key? key, this.notificationCount = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your button click logic here
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 22,
            ),
            if (notificationCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount > 9 ? '9+' : '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
