import 'package:flutter/material.dart';
import 'package:multi_store/providers/cart_provider.dart';
import 'package:multi_store/providers/wishlist_provider.dart';
import 'package:multi_store/screens/login_screens/customer_login.dart';
import 'package:multi_store/screens/login_screens/customer_signup.dart';
import 'package:multi_store/screens/login_screens/supplier_login.dart';
import 'package:multi_store/screens/login_screens/supplier_signup.dart';
import 'package:multi_store/screens/main_screens/home_screen.dart';
import 'package:multi_store/screens/main_screens/supplier_home_screen.dart';
import 'package:multi_store/screens/main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Wish(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: const WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/user_screen': (context) => const HomePage(),
        '/supplier_screen': (context) => const SupplierHomePage(),
        '/customer_register': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_register': (context) => const SupplierRegister(),
        '/supplier_login': (context) => const SupplierLogin(),
      },
    );
  }
}
