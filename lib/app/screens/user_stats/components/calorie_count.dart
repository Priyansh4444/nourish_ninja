// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../general_components/ninja_themes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DietView extends StatefulWidget {
  const DietView({super.key, this.animationController, this.animation});

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  _CalorieCountState createState() => _CalorieCountState(
      animation: animation, animationController: animationController);
}

Future<Map<String, dynamic>> getUser(String uuid) async {
  // Fetch the data of the user's UUID from Firestore
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uuid).get();

  print(snapshot.data().runtimeType);
  Map<String, dynamic> userData = snapshot.data()!;
  print(userData);
  return snapshot.data()!;
}

Future<Map<String, dynamic>> getUserGoals(String uuid) async {
  // Fetch the data of the user's UUID from Firestore
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user_goals').doc(uuid).get();

  print(snapshot.data().runtimeType);
  Map<String, dynamic> userData = snapshot.data()!;
  print(userData);
  return snapshot.data()!;
}

class _CalorieCountState extends State<DietView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  _CalorieCountState({
    required this.animationController,
    required this.animation, // Add initializer for 'userId' field
  });

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  String? userId;
  Map<String, dynamic> user_data = {};
  Map<String, dynamic> user_goals = {};
  int? protein;
  int? carbs;
  int? fat;
  int? calories;
  int? leftCalories;
  
  @override
  void initState() {
    super.initState();
    print("I am here Now");
    animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    
    animationController!.forward();
  }


  Future<void> fetchData() async {
    
    currentUser = auth.currentUser;
    userId = currentUser!.uid;
    
    user_data = await getUser(userId!);
    user_goals = await getUserGoals(userId!);
    print('---------------------------------');
    print(user_data);
    print('---------------------------------');
    print(user_goals);
  }
  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchData().then((value) {
      protein = ((user_goals['protein'] ?? 0) - (user_data['protein']['grams'] ?? 0)).toInt();
      carbs = ((user_goals['carbohydrates'].toInt() ?? 0) - (user_data['carbohydrates'].toInt() ?? 0)).toInt();
      fat = ((user_goals['fat'].toInt() ?? 0) - (user_data['totalFat']['grams'].toInt() ?? 0)).toInt();
      
    }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loader while fetching data
          return CircularProgressIndicator();
        } else {
        return AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: animation!,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation!.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: NourishNinjaTheme.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: NourishNinjaTheme.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 4),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 48,
                                            width: 2,
                                            decoration: BoxDecoration(
                                              color: HexColor('#87A0E5')
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 4, bottom: 2),
                                                  child: Text(
                                                    'Eaten',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: NourishNinjaTheme
                                                          .fontName,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      letterSpacing: -0.1,
                                                      color: NourishNinjaTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 28,
                                                      height: 28,
                                                      child: Image.asset(
                                                          "assets/images/food.png"),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, bottom: 3),
                                                      child: Text(
                                                        '${(user_data['calories'] * animation!.value).toInt()}',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              NourishNinjaTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: NourishNinjaTheme
                                                              .darkerText,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, bottom: 3),
                                                      child: Text(
                                                        'Kcal',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              NourishNinjaTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          letterSpacing: -0.2,
                                                          color: NourishNinjaTheme
                                                              .grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 48,
                                            width: 2,
                                            decoration: BoxDecoration(
                                              color: HexColor('#F56E98')
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 4, bottom: 2),
                                                  child: Text(
                                                    'Burned',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: NourishNinjaTheme
                                                          .fontName,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      letterSpacing: -0.1,
                                                      color: NourishNinjaTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 28,
                                                      height: 28,
                                                      child: Image.asset(
                                                          "assets/images/fire.png"),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, bottom: 3),
                                                      child: Text(
                                                        '${(102 * animation!.value).toInt()}',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              NourishNinjaTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: NourishNinjaTheme
                                                              .darkerText,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8, bottom: 3),
                                                      child: Text(
                                                        'Kcal',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              NourishNinjaTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          letterSpacing: -0.2,
                                                          color: NourishNinjaTheme
                                                              .grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Center(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: NourishNinjaTheme.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            border: new Border.all(
                                                width: 4,
                                                color: NourishNinjaTheme
                                                    .nearlyDarkBlue
                                                    .withOpacity(0.2)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${((user_goals['fat']*9/0.2 - user_data['calories']) * animation!.value).toInt()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      NourishNinjaTheme.fontName,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 24,
                                                  letterSpacing: 0.0,
                                                  color: NourishNinjaTheme
                                                      .nearlyDarkBlue,
                                                ),
                                              ),
                                              Text(
                                                'Kcal left',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      NourishNinjaTheme.fontName,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: NourishNinjaTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomPaint(
                                          painter: CurvePainter(
                                              colors: [
                                                NourishNinjaTheme.nearlyDarkBlue,
                                                HexColor("#8A98E8"),
                                                HexColor("#8A98E8")
                                              ],
                                              angle: (user_data['calories']/(user_goals['fat']*9/0.2)*360) +
                                                  (360 - user_data['calories']/(user_goals['fat']*9/0.2)*360) *
                                                      (1.0 - animation!.value)),
                                          child: SizedBox(
                                            width: 108,
                                            height: 108,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 8),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: NourishNinjaTheme.background,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Carbs',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: NourishNinjaTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: NourishNinjaTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color:
                                              HexColor('#87A0E5').withOpacity(0.2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width:
                                                  ((70 / (user_goals["carbohydrates"]!.clamp(1,70)/user_data['carbohydrates']!.clamp(1,70)).toInt().clamp(1,70)) * animation!.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  HexColor('#87A0E5'),
                                                  HexColor('#87A0E5')
                                                      .withOpacity(0.5),
                                                ]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${carbs}g left',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: NourishNinjaTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: NourishNinjaTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Protein',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: NourishNinjaTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: NourishNinjaTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 4,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: HexColor('#F56E98')
                                                  .withOpacity(0.2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                    width: ((70 / (user_goals["protein"]/user_data['protein']['grams']).toInt().clamp(1,70) )*
                                                      animationController!.value),
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor('#F56E98')
                                                          .withOpacity(0.1),
                                                      HexColor('#F56E98'),
                                                    ]),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            '${protein}g left',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  NourishNinjaTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: NourishNinjaTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Fat',
                                          style: TextStyle(
                                            fontFamily: NourishNinjaTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: NourishNinjaTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, top: 4),
                                          child: Container(
                                            height: 4,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: HexColor('#F1B440')
                                                  .withOpacity(0.2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: ((70 / (user_goals["fat"]/user_data['totalFat']['grams']).toInt().clamp(1,70)) *
                                                      animationController!.value),
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor('#F1B440')
                                                          .withOpacity(0.1),
                                                      HexColor('#F1B440'),
                                                    ]),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            '${fat}g left',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  NourishNinjaTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: NourishNinjaTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
      }
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: const [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint.shader = gradient1.createShader(rect);
    cPaint.color = Colors.white;
    cPaint.strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}