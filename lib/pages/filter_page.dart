import 'package:flutter/material.dart';

import '../providers/recipes.provider.dart';
import'package:provider/provider.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // @override
  // void initState() {
  //   Provider.of<RecipesProvider>(context, listen: false).getFilteredResult();
  //   super.initState();
  // }
  var selectedUserValue = {};



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [GestureDetector(onTap: (){Navigator.of(context).pop();},
            child:Container(height: 60,child: Text('clear'),)),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: Wrap(
                      // space between chips
                        spacing: 10,
                        // list of chips
                        children: [
                          InkWell(
                            onTap: () {
                              selectedUserValue['type'] = "breakfast";
                              setState(() {});
                            },
                            child: Chip(
                              label: Text('Breakfast'),
                              backgroundColor: selectedUserValue['type'] == "breakfast"
                                  ? Colors.orange
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectedUserValue['type'] = "lunch";
                              setState(() {});
                            },
                            child: Chip(
                              label: Text('Lunch'),
                              backgroundColor: selectedUserValue['type'] == "lunch"
                                  ? Colors.orange
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectedUserValue['type'] = "dinner";
                              setState(() {});
                            },
                            child: Chip(
                              label: Text('Dinner'),
                              backgroundColor: selectedUserValue['type'] == "dinner"
                                  ? Colors.orange
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            ),
                          ),
                        ]),
                  ),
    Padding(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),),
                Slider(min: 1, max:200
                  ,  value: selectedUserValue['servings'], onChanged: (double newvalue){
                      selectedUserValue['servings']=newvalue.round();
                      setState(() {

                      });
                    }), Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),),
                  Slider(min: 1, max:200
                      ,  value: selectedUserValue['total_time'], onChanged: (double newvalue){
                        selectedUserValue['total_time']=newvalue.round();
                        setState(() {

                        });
                      }), Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),),
                  Slider(min: 1, max:200
                      ,  value: selectedUserValue['calories'], onChanged: (double newvalue){
                        selectedUserValue['calories']=newvalue.round();
                        setState(() {

                        });
                      })],

              ),
            ],
          ),

    );
  }
}