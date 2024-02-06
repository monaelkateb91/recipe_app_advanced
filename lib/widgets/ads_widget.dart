import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/ads.provider.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class AdsWidget extends StatefulWidget {
  const AdsWidget({super.key});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<AdsProvider>(context, listen: false).getAds();
  }

  @override
  void dispose() {
    Provider.of<AdsProvider>(context, listen: false).disposeCarousel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(
        builder: (context, adprovider, _) => adprovider.adsList == null
            ? const CircularProgressIndicator()
            : (adprovider.adsList?.isEmpty ?? false)
                ? const Text('no data found')
                : Column(children: [
                    CarouselSlider(
                      carouselController: adprovider.carouselController,
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 200,
                          viewportFraction: .75,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          onPageChanged: (index, _) =>
                              adprovider.onPageChanged(index),
                          enlargeFactor: .3),
                      items: adprovider.adsList!.map((ad) {
                        return Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(ad.image!))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    ad.title.toString(),
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ), DotsIndicator(dotsCount: adprovider.adsList!.length,position: adprovider.sliderIndex,onTap: (position)=>adprovider.onDotTapped(position),
          decorator: DotsDecorator(size: const Size.square(9.0),activeSize: const Size(18.0,9.0),activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),)
                  ]));
  }
}
