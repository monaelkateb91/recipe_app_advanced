import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_advanced/model/recipes.model.dart';
import 'package:recipe_app_advanced/pages/ingredients_page.dart';
import 'package:recipe_app_advanced/providers/auth.provider.dart';
import 'package:recipe_app_advanced/widgets/recipe_widget.dart';

import '../providers/recipes.provider.dart';
import '../utils/numbers.dart';
import '../widgets/ads_widget.dart';
import '../widgets/section_header.dart';
import 'favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    Provider.of<RecipesProvider>(context, listen: false).getFreshRecipes();
    Provider.of<RecipesProvider>(context, listen: false)
        .getRecommandedRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        menuBackgroundColor: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        disableDragGesture: true,
        mainScreenTapClose: true,
        controller: controller,
        drawerShadowsBackgroundColor: Colors.grey,
        menuScreen: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    controller.close?.call();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Ingredients()));
                  },
                  leading: Icon(Icons.food_bank),
                  title: Text("Ingredients"),
                ),
                ListTile(
                  onTap: () {
                    controller.close?.call();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavouritesPage()));
                  },
                  leading: const Icon(Icons.favorite_outlined),
                  title: const Text('Favourites'),
                ),
                ListTile(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut(context);
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Sign out"))
              ],
            ),
          ),
        ),
        mainScreen: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Numbers.appHorizontalPadding),
                child: InkWell(
                    onTap: () {
                      controller.toggle!();
                    },
                    child: Icon(Icons.menu)),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Icon(Icons.notifications),
                )
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              AdsWidget(),
              SectionHeader(sectionName: 'Today\'s Fresh Recipes'),
              SizedBox(
                height: 300,
                child: Consumer<RecipesProvider>(
                    builder: (ctx, recipesProvider, _) => recipesProvider
                                .freshRecipesList ==
                            null
                        ? const CircularProgressIndicator()
                        : (recipesProvider.freshRecipesList?.isEmpty ?? false)
                            ? const Text('No Data Found')
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    recipesProvider.freshRecipesList!.length,
                                itemBuilder: (ctx, index) => RecipeWidget(
                                      recipe: recipesProvider
                                          .freshRecipesList![index],
                                    ))),
              ),
                      SectionHeader(sectionName: 'Recommended'),
                      SizedBox(
                        height: 300,
                        child: Consumer<RecipesProvider>(
                            builder: (ctx, recipesProvider, _) => recipesProvider
                                .recommendedRecipesList ==
                                null
                                ? const CircularProgressIndicator()
                                : (recipesProvider.freshRecipesList?.isEmpty ?? false)
                                ? const Text('No Data Found')
                                : ListView.builder(
                                shrinkWrap: true,

                                scrollDirection: Axis.vertical,
                                itemCount:
                                recipesProvider.recommendedRecipesList!.length,
                                itemBuilder: (ctx, index) => RecipeWidget(
                                  recipe: recipesProvider
                                      .recommendedRecipesList![index],
                                ))),
                      ),
            ]))
            ))
    )
    ;
  }
}
