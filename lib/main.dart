import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/firebase_options.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_advanced/pages/splash_screen.dart';
import 'package:recipe_app_advanced/providers/ads.provider.dart';
import 'package:recipe_app_advanced/providers/auth.provider.dart';
import 'package:recipe_app_advanced/providers/ingredients.provider.dart';
import 'package:recipe_app_advanced/providers/recipes.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    var preference = await SharedPreferences.getInstance();

    GetIt.I.registerSingleton<SharedPreferences>(preference);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('-----$e-----');
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => AdsProvider()),
      ChangeNotifierProvider(create: (_) => IngredientsProvider()),
      ChangeNotifierProvider(create: (_)=> RecipesProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OverlayKit(
        child: MaterialApp(
      theme: ThemeData(
          fontFamily: 'Helix',
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey.shade200,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xfff45b00),
            primary: const Color(0xfff45b00),
            secondary: const Color(0xfff45b00),
          ),
          useMaterial3: true),
      home: const SplashScreen(),
    ));
  }
}
