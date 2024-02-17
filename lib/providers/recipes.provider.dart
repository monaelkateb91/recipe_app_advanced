import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe_app_advanced/model/recipes.model.dart';
import 'package:recipe_app_advanced/utils/toast_message_status.dart';
import 'package:recipe_app_advanced/widgets/toast_message.dart';
class RecipesProvider extends ChangeNotifier{
  List<Recipe>? _recipesList;
  List<Recipe>? get recipesList => _recipesList;
  List<Recipe>? _freshRecipesList;
  Recipe? openedRecipe;
  List<Recipe>? get freshRecipesList => _freshRecipesList;

  List<Recipe>? _recommendedRecipesList;


  List<Recipe>? get recommendedRecipesList => _recommendedRecipesList;
  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: true) // added a query and limit the number of the recipes to show
          .limit(5)
          .get();

      if (result.docs.isNotEmpty) {
        _freshRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _freshRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _freshRecipesList = [];
      notifyListeners();
    }
  }

  Future<void> getRecommandedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: false) //added a query
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        _recommendedRecipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recommendedRecipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _recommendedRecipesList = [];
      notifyListeners();
    }
  }
  Future<void> getRecipes() async{
    try{
      var result= await FirebaseFirestore.instance.collection('recipes').get();
      if(result.docs.isNotEmpty){
        _recipesList=List<Recipe>.from(result.docs.map((doc) => Recipe.fromJson(doc.data(),doc.id)));
      }else{
        _recipesList=[];
      }
      notifyListeners();
    }catch(e){
      _recipesList=[];
      notifyListeners();
    }
  }

  void addRecipeToUserRecentlyViewed(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recently_viewd_users_ids":
        FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {}
  }

  void removeRecipeToUserRecentlyViewed(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recently_viewd_users_ids":
        FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {}
  }
  Future<void> addRecipeToUserFavourite(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "favourite_users_ids":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "favourite_users_ids":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      await _updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
      Future<void> _updateRecipe(String recipeId) async { //get recipe from firebase,update recipe in all lists,
        try {
          var result = await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeId)
              .get();
          Recipe? updatedRecipe;
          if (result.data() != null) {
            updatedRecipe = Recipe.fromJson(result.data()!, result.id);
          } else {
            return;
          }

          var recipesListIndex =
          recipesList?.indexWhere((recipe) => recipe.docId == recipeId);

          if (recipesListIndex != -1) {
            recipesList?.removeAt(recipesListIndex!);
            recipesList?.insert(recipesListIndex!, updatedRecipe);
          }

          var freshRecipesListIndex =
          freshRecipesList?.indexWhere((recipe) => recipe.docId == recipeId);

          if (freshRecipesListIndex != -1) {
            freshRecipesList?.removeAt(freshRecipesListIndex!);
            freshRecipesList?.insert(freshRecipesListIndex!, updatedRecipe);
          }

          var recommandedRecipesListIndex = recommendedRecipesList
              ?.indexWhere((recipe) => recipe.docId == recipeId);

          if (recommandedRecipesListIndex != -1) { // not equal -1 it means it exists
            recommendedRecipesList?.removeAt(recommandedRecipesListIndex!); //we remove first
            recommendedRecipesList?.insert( //insert not add beacuse we are adding with index
                recommandedRecipesListIndex!, updatedRecipe);
          }

          notifyListeners();
        } catch (e) {
          print('>>>>>error in update recipe');
        }
      }



  Future<void> getSelectedRecipe(String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      if (result.data() != null) {
        openedRecipe = Recipe.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      notifyListeners();
    } catch (e) {
      print('>>>>>error in update recipe');
    }
    var value = {"type": "breakfast", "serving": 5, "total_time": 20};

    void getFilteredResult() async {
      var ref = FirebaseFirestore.instance.collection('recipes');

      for (var entry in value.entries) {
        ref.where(entry.key, isEqualTo: entry.value);
      }

      var result = await ref.get();
      if (result.docs!= null) {
      final filterdList = [];
      } else {
        return;
      }

    }
  }





  // (String query) {
  //   return FirebaseFirestore.instance
  //       .collection('recipes').doc.
  //       .map((recipeList) {
  //     return recipeList.where((recipe) {
  //       final title = recipe.title.toLowerCase();
  //       final description = recipe.description.toLowerCase();
  //       return title.contains(query.toLowerCase()) || description.contains(query.toLowerCase());
  //     }).toList();
  //   });
  }



