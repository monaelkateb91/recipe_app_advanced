import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/model/recipes.model.dart';
import 'package:recipe_app_advanced/pages/search.dart';
import 'package:recipe_app_advanced/pages/search.dart';

import 'package:recipe_app_advanced/widgets/recent_card_widged.dart';
import 'package:recipe_app_advanced/widgets/recipe_widget.dart';

class RecentlyPage extends StatefulWidget {
  const RecentlyPage({super.key});

  @override
  State<RecentlyPage> createState() => _RecentlyPageState();
}

class _RecentlyPageState extends State<RecentlyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( toolbarHeight: 200,
        title: Text('Recently viewed'),
        flexibleSpace: SearchView(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recipes')
              .where('recently_viewd_users_ids',
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshots.hasError) {
                return const Text('ERROR WHEN GET DATA');
              } else {
                if (snapshots.hasData) {
                  List<Recipe> recipesList = snapshots.data?.docs
                      .map((e) => Recipe.fromJson(e.data(), e.id))
                      .toList() ??
                      [];
                  return FlexibleGridView(
                    children: recipesList
                        .map((e) => RecentlyCard(recipe: e))
                        .toList(),
                    axisCount: GridLayoutEnum.twoElementsInRow,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  );
                } else {
                  return const Text('No Data Found');
                }
              }
            }
          }),
    );
  }
}