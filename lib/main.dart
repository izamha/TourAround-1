import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tour_around/constants/theme.dart';
import 'package:tour_around/routes/routes.dart';
import 'package:tour_around/screens/category/category_screen.dart';

// Github password & Username(princejoee): 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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MxWOpEScvFYdlpUEVIfDBa3R7FPBpa0xnRdVg1OZjq1QW1P3r6gXvbtLIy7GrTX2QcfJPKQcCcpz20NRjCjfJOD002cjVsfKZ";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TourAround',
      debugShowCheckedModeBanner: false,
      theme: theme(context),
      home: const CategoryScreen(),
      routes: routes,
    );
  }
}
