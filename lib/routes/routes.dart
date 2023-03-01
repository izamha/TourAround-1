// All routes goes here

import 'package:flutter/cupertino.dart';
import 'package:tour_around/playground.dart';
import 'package:tour_around/screens/account/account_screen.dart';
import 'package:tour_around/screens/category/category_screen.dart';
import 'package:tour_around/screens/category_detail/category_on_map_screen.dart';
import 'package:tour_around/screens/complete_profile/complete_profile.dart';
import 'package:tour_around/screens/favorite/favorite_screen.dart';
import 'package:tour_around/screens/forgot_password/forgot_password_screen.dart';
import 'package:tour_around/screens/help/help_screen.dart';
import 'package:tour_around/screens/home/home_screen.dart';
import 'package:tour_around/screens/login_success/login_success_screen.dart';
import 'package:tour_around/screens/my_places/my_places_screen.dart';
import 'package:tour_around/screens/otp/otp_screen.dart';
import 'package:tour_around/screens/settings/settings_screen.dart';
import 'package:tour_around/screens/sign_in/sign_in_screen.dart';
import 'package:tour_around/screens/sign_up/sign_up_screen.dart';
import 'package:tour_around/screens/splash/splash_screen.dart';

import '../screens/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashScreen
  SplashScreen.routeName: (context) => const SplashScreen(),
  // HomeScreen
  HomeScreen.routeName: (context) => const HomeScreen(),
  // SignUpScreen
  SignUpScreen.routeName: (context) => const SignUpScreen(),

  // SignInScreen
  SignInScreen.routeName: (context) => const SignInScreen(),

  // LoginSuccessScreen
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),

  // ProfileScreen
  ProfileScreen.routeName: (context) => const ProfileScreen(),

  // CompleteProfileScreen
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  // OTP
  OtpScreen.routeName: (context) => const OtpScreen(),
  // ForgotPasswordScreen
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  // PlaceDetailsScreen
  // MyPlacesScreen
  MyPlacesScreen.routeName: (context) => const MyPlacesScreen(),
  // FavoriteScreen
  FavoriteScreen.routeName: (context) => const FavoriteScreen(),

  // CategoryScreen
  CategoryScreen.routeName: (context) => const CategoryScreen(),

  // CategoryDetailScreen
  // CategoryDetails.routeName:(context) => const CategoryDetails(),

  // AccountScreen.routeName: (context) => const AccountScreen(),

  SettingsScreen.routeName: (context) => const SettingsScreen(),

  HelpScreen.routeName: (context) => const HelpScreen(),

  // Playground
  Playground.routeName: (context) => const Playground(),
};
