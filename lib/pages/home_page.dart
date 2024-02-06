import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_advanced/providers/auth.provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ElevatedButton( child: const Text('Sign out'),
      onPressed:(){ Provider.of<AuthProvider>(context, listen: false).signOut(context);},
    ),),);
  }
}
