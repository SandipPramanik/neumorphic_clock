import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Neumorphic Clock',
      debugShowCheckedModeBanner: false,
      home: NeumorphicClock(),
    );
  }
}

class NeumorphicClock extends StatefulWidget {
  @override
  _NeumorphicClockState createState() => _NeumorphicClockState();
}

class _NeumorphicClockState extends State<NeumorphicClock>
    with TickerProviderStateMixin {
//  ***********************LIGHT NEUMORPHIC CLOCK********************

  final Color nBackgroundColor = Colors.grey[300];
  final Color nHoursHandColor = Colors.grey[800];
  final Color nMinutesHandColor = Colors.grey[600];
  final Color nSecondsHandColor = Colors.pink;
  static final Color nLightColorShadow = Colors.white;
  static final Color nDarkColorShadow = Colors.grey[500];
  final List<Color> nGradientColors = [
    nDarkColorShadow,
    Colors.grey[400],
    Colors.grey[300],
    Colors.grey[200],
    nLightColorShadow,
  ];

//  ***********************DARK NEUMORPHIC CLOCK********************

  // final Color nBackgroundColor = Colors.grey[850];
  // final Color nHoursHandColor = Colors.pink;
  // final Color nMinutesHandColor = Colors.white;
  // final Color nSecondsHandColor = Colors.blue[800];
  // static final Color nLightColorShadow = Colors.grey[800];
  // static final Color nDarkColorShadow = Colors.grey[900];
  // final List<Color> nGradientColors = [
  //   nDarkColorShadow,
  //   Colors.grey[900],
  //   Colors.grey[850],
  //   Colors.grey[800],
  //   nLightColorShadow,
  // ];

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  AnimationController _controller1, _controller2, _controller3;
  Animation _secondsHandAnimation, _minutesHandAnimation, _hoursHandAnimation;

  @override
  void initState() {
    super.initState();
    _controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 60))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller1.repeat();
            }
          });
    _secondsHandAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller1);
    _controller2 =
        AnimationController(vsync: this, duration: Duration(minutes: 60))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller2.repeat();
            }
          });
    _minutesHandAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller2);
    _controller3 =
        AnimationController(vsync: this, duration: Duration(hours: 12))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller3.repeat();
            }
          });
    _hoursHandAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller3);
    _controller1.forward();
    _controller2.forward();
    _controller3.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).padding.top + 45.0,
              child: Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                color: nBackgroundColor,
                child: Center(
                  child: Text(
                    "WALL CLOCK",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: nBackgroundColor,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 3.0,
                      wordSpacing: 3.0,
                      shadows: [
                        Shadow(
                          color: nLightColorShadow,
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 5.0,
                        ),
                        Shadow(
                          color: nDarkColorShadow,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
//                  CLOCK FIGURE STARTS HERE
                  Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: nLightColorShadow,
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: nDarkColorShadow,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                      ],
                      gradient: LinearGradient(
                        colors: nGradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
//                        VALUES ARE ADDED
                        ClockLayout(),
//                        ............HOURS HAND...........

                        Center(
                          child: RotationTransition(
                            turns: _hoursHandAnimation,
                            child: Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(270), 30.0),
                              child: Container(
                                height: 58.0,
                                width: 6.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: nHoursHandColor),
                              ),
                            ),
                          ),
                        ),
//                        ...........MINUTES HAND.........
                        Center(
                          child: RotationTransition(
                            turns: _minutesHandAnimation,
                            child: Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(270), 37.0),
                              child: Container(
                                height: 90.0,
                                width: 4.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: nMinutesHandColor),
                              ),
                            ),
                          ),
                        ),
//                        ............SECONDS HAND...........
                        Center(
                          child: RotationTransition(
                            turns: _secondsHandAnimation,
                            child: Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(270), 37.5),
                              child: Container(
                                height: 115.0,
                                width: 2.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: nSecondsHandColor),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 15.0,
                            width: 15.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: nBackgroundColor,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClockLayout extends StatelessWidget {
//  ==================LIGHT NEUMORPHIC===============

  static final Color nTextColor = Colors.grey[800];

//  ====================DARK NEUMORPHIC==================

//  static final Color nTextColor = Colors.grey[400];

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  final TextStyle kNumberTextStyle = TextStyle(
    fontSize: 20.0,
    color: nTextColor,
    fontWeight: FontWeight.bold,
  );

  Widget getValuesAndDirection(int value, double direction) {
    return Center(
      child: Transform.translate(
        offset: Offset.fromDirection(getRadiansFromDegree(direction), 95.0),
        child: Text(
          value.toString(),
          style: kNumberTextStyle,
        ),
      ),
    );
  }

  Widget getAngleAndDirection(double angle, double direction) {
    return Transform.translate(
      offset: Offset.fromDirection(getRadiansFromDegree(direction), 95.0),
      child: Transform.rotate(
        angle: getRadiansFromDegree(angle),
        child: Center(
          child: Container(
            height: 15.0,
            width: 3.0,
            decoration: BoxDecoration(
              color: nTextColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        getValuesAndDirection(12, 270),
        // getValuesAndDirection(1, 300),
        getAngleAndDirection(30, 300),
        // getValuesAndDirection(2, 330),
        getAngleAndDirection(60, 330),
        getValuesAndDirection(3, 360),
        // getValuesAndDirection(4, 30),
        getAngleAndDirection(120, 30),
        // getValuesAndDirection(5, 60),
        getAngleAndDirection(150, 60),
        getValuesAndDirection(6, 90),
        // getValuesAndDirection(7, 120),
        getAngleAndDirection(210, 120),
        // getValuesAndDirection(8, 150),
        getAngleAndDirection(240, 150),
        getValuesAndDirection(9, 180),
        // getValuesAndDirection(10, 210),
        getAngleAndDirection(300, 210),
        // getValuesAndDirection(11, 240),
        getAngleAndDirection(330, 240),
      ],
    );
  }
}
