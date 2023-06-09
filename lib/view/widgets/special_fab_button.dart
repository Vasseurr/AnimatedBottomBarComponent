// ignore_for_file: prefer_const_constructors, avoid_print, prefer_final_fields, must_be_immutable

import 'dart:developer';

import 'package:animatedbb/view/notification_page.dart';
import 'package:animatedbb/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../mail.dart';

class SpecialFABButton extends StatefulWidget {
  const SpecialFABButton({Key? key}) : super(key: key);

  @override
  _SpecialFABButtonState createState() => _SpecialFABButtonState();
}

class _SpecialFABButtonState extends State<SpecialFABButton>
    with SingleTickerProviderStateMixin {
  HomeController _homeController = Get.find<HomeController>();
  late AnimationController _animationController;
  Icon mainFabIcon = Icon(Icons.add);
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });
    _translateButton = Tween<double>(
      /* begin: 0,
      end: _fabHeight,*/
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.75,
        curve: _curve,
      ),
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
    return Padding(
      padding: EdgeInsets.only(bottom: context.height * .02),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform(
              transform: Matrix4.translationValues(
                  0.0, _translateButton.value * 3.0, 0),
              child: notificationButton()),
          Transform(
              transform:
                  Matrix4.translationValues(0.0, _translateButton.value * 2, 0),
              child: mailButton()),
          Transform(
              transform:
                  Matrix4.translationValues(0.0, _translateButton.value, 0),
              child: profileButton()),
          mainFAB(context),
        ],
      ),
    );
    /*Stack(
      children: [
        Transform(
            transform: Matrix4.translationValues(
                0.0, -_translateButton.value * 3.6, 0.0),
            child: notificationButton()),
        Transform(
            transform: Matrix4.translationValues(
                0.0, -_translateButton.value * 2.4, 0.0),
            child: mailButton()),
        Transform(
            transform: Matrix4.translationValues(
                0.0, -_translateButton.value * 1.2, 0.0),
            child: profileButton()),
        mainFAB(context),
      ],
    );*/
  }

  Widget notificationButton() => FloatingActionButton(
      heroTag: "Notifications",
      onPressed: () {
        log("Notifications");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationPage(),
            ));
      },
      backgroundColor: Colors.blue.shade900,
      child: Icon(Icons.notification_add, size: 40));

  FloatingActionButton mailButton() => FloatingActionButton(
        heroTag: "Mail",
        onPressed: () {
          log("Mail");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MailPage(),
              ));
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.mail, size: 40),
      );

  FloatingActionButton profileButton() => FloatingActionButton(
        heroTag: "Profile",
        onPressed: () {
          log("Profile");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ));
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.person, size: 40),
      );

  FloatingActionButton mainFAB(BuildContext context) {
    return FloatingActionButton(
        onPressed: animate,
        backgroundColor: /*widget.type == 1
            ? */
            _homeController.mainFabIsClosed == true
                ? Colors.blue.shade900
                : Colors.red,
        /* : _homeController.otherFabIsClosed == true
                ? Colors.blue.shade900
                : Colors.red,*/
        child: /* widget.type == 1
            ?*/
            _homeController.mainFabIsClosed == true
                ? mainFabIcon
                : Icon(Icons.close)
        /* : _homeController.otherFabIsClosed == true
                ? mainFabIcon
                : Icon(Icons.close)*/
        );
  }

  void animate() {
    /*if (widget.type == 1) {
      if (_homeController.mainFabIsClosed) {
        print("Opening");
        _animationController.forward();
      } else {
        print("Closing");
        _animationController.reverse();
      }
      _homeController.mainFabIsClosed = !_homeController.mainFabIsClosed;
    } else {
      if (_homeController.otherFabIsClosed) {
        print("Opening");
        _animationController.forward();
      } else {
        print("Closing");
        _animationController.reverse();
      }*/
    if (_homeController.mainFabIsClosed) {
      print("Opening");
      _animationController.forward();
    } else {
      print("Closing");
      _animationController.reverse();
    }
    _homeController.mainFabIsClosed = !_homeController.mainFabIsClosed;
    _homeController.otherFabIsClosed = !_homeController.otherFabIsClosed;
    // }
  }
}
