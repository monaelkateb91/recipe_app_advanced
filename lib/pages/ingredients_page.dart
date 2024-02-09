import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/providers/ingredients.provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<IngredientsProvider>(
          builder: (context, ingredientprovider, _) =>
              ingredientprovider.ingredientsList == null
                  ? const CircularProgressIndicator()
                  : (ingredientprovider.ingredientsList?.isEmpty ?? false)
                      ? const Text('no data found')
                      : ListView.builder(
                          itemCount: ingredientprovider.ingredientsList!.length,
                          itemBuilder: (context, index) => ListTile(
                                  leading: Checkbox(
                                value: ingredientprovider
                                    .ingredientsList![index].users_id
                                    ?.contains(
                                        FirebaseAuth.instance.currentUser?.uid),
                                onChanged: (value) {
                                  ingredientprovider.addIngredientToUser(
                                      ingredientprovider
                                          .ingredientsList![index].docId!,
                                      value ?? false);
                                },
                              ), title:  Text(ingredientprovider
                              .ingredientsList![index].name ??
                              'No Name'),
                          )
              )
      ),
    );
  }
}
