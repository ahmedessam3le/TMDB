import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb/config/routes/app_routes.dart';
import 'package:tmdb/core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() =>
      Navigator.of(context).pushReplacementNamed(Routes.popularPeoples);

  _startDelay() {
    _timer = Timer(Duration(milliseconds: 2000), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.tmdbLogo),
      ),
    );
  }
}
