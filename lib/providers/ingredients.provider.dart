import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ingredients.model.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/toast_message_status.dart';
import '../widgets/toast_message.dart';
class IngredientsProvider extends ChangeNotifier{
  List<Ingredients> ? _ingredientsList;
  List<Ingredients> ? get ingredientsList=>_ingredientsList;


  Future<void> getIngredients() async {
    try { var result= await FirebaseFirestore.instance.collection('ingredients').get();
      if(result.docs.isNotEmpty)
     {
       _ingredientsList=List<Ingredients>.from(result.docs.map((doc) => Ingredients.fromJson(doc.data(),doc.id)));
     }else{
        _ingredientsList=[];
      }
      notifyListeners();
     }catch(e){
      _ingredientsList=[];
      notifyListeners();
    }

  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "users_id":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
          //arrayunion leave the elements without removing and add another new element
        });
      } else {
        await FirebaseFirestore.instance
            .collection('ingredients')
            .doc(ingredientId)
            .update({
          "users_id":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getIngredients();
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
}

