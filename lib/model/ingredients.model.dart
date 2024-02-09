class Ingredients{
  String ? name;
  String ? docId;
  List<String>? users_id;


  Ingredients();

  Map<String,dynamic> tojson(){
    return {
        "name":name,
      "users_id":users_id



  };}
  Ingredients.fromJson(Map<String,dynamic>data,[String ? id]){
    docId=id;
    name=data['name'];
    users_id=data['users_id'] !=null ? List<String>.from(data['users_id'].map((e)=>e.toString())):null;
  }
}