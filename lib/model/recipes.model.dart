class Recipe{
  String? docId;
  num? calories;
  String? description;
  String ? title;
  Map<String, String>? directions;
  String? imageUrl;
  List<String>? ingredients;
  num? rate;
  num? servings;
  List<String>? favourite_users_ids;
  num? total_time;
  String? type;
List<String>? recently_viewd_users_ids;

  Recipe();

  //fromjson read from json , to json send data to server

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    calories = data['calories'];
    description = data['description'];
    directions = data['directions'] != null
        ? Map<String, String>.from(data['directions'])
        : null;
    imageUrl = data['imageUrl'];
    ingredients = data['ingredients'] != null
        ? List<String>.from(data['ingredients'].map((e) => e.toString()))
        : null;
    favourite_users_ids = data['favourite_users_ids'] != null
        ? List<String>.from(
        data['favourite_users_ids'].map((e) => e.toString()))
        : null;
    rate = data['rate'];
    servings = data['servings'];
    title = data['title'];
    total_time = data['total_time'];
    type = data['type'];
    recently_viewd_users_ids = data['frecently_viewd_users_ids'] != null
        ? List<String>.from(
        data['recently_viewd_users_ids'].map((e) => e.toString()))
        : null;

  }

  Map<String, dynamic> toJson() {
    return {
      "calories": calories,
      "description": description,
      "directions": directions,
      "imageUrl": imageUrl,
      "ingredients": ingredients,
      "favourite_users_ids": favourite_users_ids,
      "rate": rate,
      "servings": servings,
      "title": title,
      "total_time": total_time,
      "type": type,
    };
  }
}