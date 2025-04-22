import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initStart = DateTime.now();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCTSUO5bdNrsq-aKaWjHp1PBEj514XfT1Y",
      appId: "1:1234567890:android:abcdef1234567890",
      messagingSenderId: "1234567890",
      projectId: "fyp2025-9fcd6",
      databaseURL: "https://fyp2025-9fcd6-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );
  final initDuration = DateTime.now().difference(initStart);
  print("✅ Firebase initialized in ${initDuration.inMilliseconds}ms");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Sensor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }

        if (snapshot.hasData && snapshot.data != null) {
          return DeveloperProfile();
        } else {
          return SignInScreen();
        }
      },
    );
  }

  Future<User?> _getCurrentUser() async {
    final start = DateTime.now();
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(milliseconds: 300)); // simulate check delay
    final duration = DateTime.now().difference(start);
    print("🔍 Auth status check took ${duration.inMilliseconds}ms");
    return user;
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text("Loading...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
