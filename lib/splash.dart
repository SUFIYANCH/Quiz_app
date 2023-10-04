// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:music_player/welcome.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 2), () {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const Welcome(),
//           ));
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFFFC107),
//         body: Center(child: Image.asset("assets/splashimg.png")));
//   }
// }
