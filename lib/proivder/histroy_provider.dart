import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleController extends ChangeNotifier {
  @override
  void onInit() {
    // TODO: implement onInit
    getList();
    getList2();
  }

  GoogleController() {
    getList();
    getList2();
  }

  TextEditingController txtSearch = TextEditingController();
  String m1 = 'Google';
  int variable = 0;
  int number = 0;

  List<String> dataStore = [];
  List<String> urlData = [];
  List<String> searchData = [];
  List<String> searchUrlData = [];

  void searchengine(String value, String data) {
    m1 = value!; // Update the group value
    print(value);
    notifyListeners();
  }

  Future<void> setData(String name, String url) async {
    dataStore.add(name);
    urlData.add(url);
    print(dataStore);
    print(urlData);
    final SharedPreferences ref = await SharedPreferences.getInstance();
    ref.setStringList('search', dataStore);
    ref.setStringList('url', urlData);
    notifyListeners();
  }

  Future<void> searchHistory(String name, String url) async {
    searchData.add(name);
    searchUrlData.add(url);
    final SharedPreferences ref = await SharedPreferences.getInstance();
    ref.setStringList('search1', searchData);
    ref.setStringList('url1', searchUrlData);
    notifyListeners();
  }

  Future<void> removeData(int index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dataStore.removeAt(index);
    urlData.removeAt(index);
    notifyListeners();
    sharedPreferences.setStringList("search", dataStore);
    sharedPreferences.setStringList("url", urlData);
  }

  Future<void> removeSearchData(int index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    searchUrlData.removeAt(index);
    searchData.removeAt(index);
    notifyListeners();
    sharedPreferences.setStringList("search1", searchData);
    sharedPreferences.setStringList("url1", searchUrlData);
  }

  Future<void> getList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dataStore = sharedPreferences.getStringList('search') ?? [];
    urlData = sharedPreferences.getStringList('url') ?? [];
    notifyListeners();
  }

  Future<void> getList2() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    searchData = sharedPreferences.getStringList('search1') ?? [];
    searchUrlData = sharedPreferences.getStringList('url1') ?? [];
    notifyListeners();
  }
}

String data = '';

void handleClick(String value) {
  switch (value) {
    case 'All BookMark':
      break;
    case 'Search Engine':
      break;
  }
}
