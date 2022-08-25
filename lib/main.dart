import 'package:flutter/material.dart';
import 'package:multi_store/views/screens/login_screens/customer_signup.dart';
import 'package:multi_store/views/screens/main_screens/home_screen.dart';
import 'package:multi_store/views/screens/main_screens/supplier_home_screen.dart';
import 'package:multi_store/views/screens/main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter multi store',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      // home: const WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/user_screen': (context) => const HomePage(),
        '/supplier_screen': (context) => const SupplierHomePage(),
        '/customer_register': (context) => const CustomerRegister(),
      },
    );
  }
}
