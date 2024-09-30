import 'package:HandcraftShop/src/constants/colors.dart';
import 'package:HandcraftShop/src/constants/image_string.dart';
import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(microseconds: 1600),
            top: animate ? 0 : -30,
            left: animate ? 0 : -30,
              child: const Image(image: AssetImage(splashTopIcon))),
          AnimatedPositioned(
            duration: const Duration(microseconds: 1600),
              top: 80,
              left: animate ? defaultSize : -80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appName, style: Theme.of(context).textTheme.headlineLarge,),
                  Text(appTagLine, style: Theme.of(context).textTheme.headlineSmall,)
                ],
              )
          ),
          Positioned(
              bottom: 40,
              right: 0,
              child: Image(
                  image: AssetImage(splashImage),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,)

          ),
           Positioned(
            bottom: 40,
              right: defaultSize,
              child: Container(
                width: splashContainerSize,
                height: splashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.deepOrange,
                ),
              ),
          ),
        ],

      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome))
  }

}