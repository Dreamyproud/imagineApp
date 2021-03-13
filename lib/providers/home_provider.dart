import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  int id;
  String name;
  String image;
  String position;
  String date;
  String summary;

  int get _id => id;

  String get _name => name;

  String get _image => image;

  String get _position => position;

  String get _date => date;

  String get _summary => summary;

  set _id(int newId) {
    id = newId;
    notifyListeners();
  }

  set _name(String newName) {
    name = newName;
    notifyListeners();
  }

  set _image(String newImage) {
    image = newImage;
    notifyListeners();
  }

  set _position(String newPosition) {
    position = newPosition;
    notifyListeners();
  }

  set _date(String newDate) {
    name = newDate;
    notifyListeners();
  }

  set _summary(String newSummary) {
    summary = newSummary;
    notifyListeners();
  }
}
