import 'package:hive_flutter/hive_flutter.dart';

class TacheBaseDeDonne {

  List ToDoList = [];

  final _myBox = Hive.box("myBox");

  void initalData(){
    if (_myBox.get("TODOLIST")!=null) {
      ToDoList = _myBox.get("TODOLIST");
    } else {
      _myBox.put("TODOLIST", ToDoList);
    }
  }

  void loadData(){
    ToDoList = _myBox.get("TODOLIST");
  }

  void updateData(){
    _myBox.put("TODOLIST", ToDoList);
  }
  


}