import 'dart:async';
import 'dart:convert' as convert;
import 'package:all_events_practical/data_provider/api_provider.dart';
import 'package:all_events_practical/model/category_event_model.dart';
import 'package:all_events_practical/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

@RxBloc()
class ExploreBloc extends RxBlocTypeBase {
  TextEditingController eventSearchController = TextEditingController();

  //variable
  final _categoryListStream = BehaviorSubject<List<CategoryModel>>();
  final _eventModelData = BehaviorSubject<CategoryEventModel>();
  final _eventListStream = BehaviorSubject<List<Item>>();
  final _selectedCategoryNameStream = BehaviorSubject<String>();

  //Loader
  final isDataLoaded = BehaviorSubject<bool>.seeded(false);

  //Get

  //category list
  Stream<List<CategoryModel>> get getCategoryListStream =>
      _categoryListStream.stream;

  //selected category name
  Stream<String> get getSelectedCategoryNameStream =>
      _selectedCategoryNameStream.stream;

  //search event list
  Stream<List<Item>> get getSearchEventListStream =>
      _eventListStream.transform(streamTransformer);

  //filtered event list after search
  BehaviorSubject<List<Item>> get getFilteredList => _eventListStream;

  // Set
  set setEventList(List<Item> list) => _eventListStream.sink.add(list);

  set setSelectedCategoryName(String name) =>
      _selectedCategoryNameStream.sink.add(name);

  // GET ALL CATEGORY
  Future<void> getCategoryData() async {
    try{
      isDataLoaded.sink.add(true);
      http.Response categoryResponse = await ApiProvider.getAPI(
          "https://allevents.s3.amazonaws.com/tests/categories.json");
      if (categoryResponse.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(categoryResponse.body);
        _categoryListStream.value = (jsonResponse as List)
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();

        isDataLoaded.sink.add(false);
        print('Category stream value: ${_categoryListStream.value}.');
      } else {
        print('Request failed with status: ${categoryResponse.statusCode}.');
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  // GET ALL EVENTS BY CATEGORY
  Future<void> getEventDataByCategory({String? selectedCategory}) async {
    try{
      isDataLoaded.sink.add(true);
      http.Response selectedCategoryResponse = await ApiProvider.getAPI(
          "https://allevents.s3.amazonaws.com/tests/${(selectedCategory != null) ? selectedCategory : "all"}.json");

      if (selectedCategoryResponse.statusCode == 200) {
        isDataLoaded.sink.add(false);

        final jsonResponse = convert.jsonDecode(selectedCategoryResponse.body);

        //Event Model Data
        _eventModelData.value = CategoryEventModel.fromJson(jsonResponse);

        //Event List Data
        _eventListStream.value = _eventModelData.value.item!;
        setEventList = _eventModelData.value.item!;

        //set selected category name value
        setSelectedCategoryName = selectedCategory ?? "all";
      } else {
        print(
            'Request failed with status: ${selectedCategoryResponse.statusCode}.');
      }
      print('selected Category JSON: $selectedCategoryResponse');
    }
    catch(e){
      print(e.toString());
    }
  }

  // Find the matching data on Search Text
  // Replace StreamTransformer to ScanStreamTransformer
  StreamTransformer<List<Item>, List<Item>> get streamTransformer =>
      StreamTransformer<List<Item>, List<Item>>.fromHandlers(
        handleData: (list, sink) {
          if ((eventSearchController.text).isNotEmpty) {
            List<Item> newList = list.where(
              (item) {
                return item.eventname!
                        .toLowerCase()
                        .contains(eventSearchController.text.toLowerCase()) ||
                    item.eventnameRaw!
                        .toLowerCase()
                        .contains(eventSearchController.text.toLowerCase());
              },
            ).toList();
            return sink.add(newList);
          } else {
            return sink.add(list);
          }
        },
      );

  // Search
  onSearch(query) {
    getFilteredList.add(getFilteredList.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
