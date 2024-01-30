import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_advanced/providers/auth.provider.dart';
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
    providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
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
    return Container();
  }
}
