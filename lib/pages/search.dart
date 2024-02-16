

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../model/recipes.model.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';

import '../widgets/recipe_widget.dart';





class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _MyAppState();
}

class _MyAppState extends State<SearchView> {
  String name = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 40,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  name= value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  filled: true,

                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('recipes').where('title', isEqualTo: name).snapshots(),

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
        .map((e) => RecipeWidget(recipe: e))
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
    }),);
  }
}