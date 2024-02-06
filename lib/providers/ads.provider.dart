import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ads.model.dart';


class AdsProvider extends ChangeNotifier{
List <Ad> ?_adslist; //_private because its read only
// getter
List<Ad>? get adsList=>_adslist;

  int sliderIndex = 0;
  CarouselController? carouselController;
  Ad? _ad;

  Ad? get ad => _ad;

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void onDotTapped(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }
  Future<void> getCertinAd(String id) async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('ads').doc(id).get();
      if (result.exists) {
        _ad = Ad.fromJson(result.data() ?? {}, result.id);
      } else {
        _ad = null;
      }
      notifyListeners();
    } catch (e) {
      _ad = null;
      notifyListeners();
    }
  }

  void initCarousel() {
    carouselController = CarouselController();
  }
Future <void> getAds() async{

  try{
    var result= await FirebaseFirestore.instance.collection('ads').get();
    if (result.docs.isNotEmpty){
_adslist=List<Ad>.from(result.docs.map((doc) => Ad.fromJson(doc.data(),doc.id))); //returns every ad
    } else{
      _adslist=[];
    }
    notifyListeners();
  }catch(e){
    _adslist=[];
    notifyListeners();
  }
}

  void disposeCarousel() {
    carouselController = null;
  }
}