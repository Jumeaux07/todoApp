import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_list.dart';
import 'package:todo_app/utils/todo_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _myBox = Hive.box("myBox");
  var newTimes = null;

  TacheBaseDeDonne db = TacheBaseDeDonne();

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateData();
  }

  void ajouterDelais()async {
      newTimes =  showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      );
  }

  void enregisterTache() {
    if (_controller.text != "" ) {
      setState(() {
        db.ToDoList.add([_controller.text, false, newTimes]);
      });
      db.updateData();
      _controller.clear();
      Navigator.of(context).pop();
    }else{
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Aucune tache ajoutée")));
    }
    
  }

  void ajouterTache() {
    showDialog(
        context: context,
        builder: (builder) {
          return DialogBox(
            controller: _controller,
            onSave: enregisterTache,
            onCancel: () => Navigator.of(context).pop(),
            newTime: newTimes, 
            onNewTime:  ajouterDelais,
          );
        });
  }

  void supprimerTache(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
      db.updateData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    db.initalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ajouterTache();
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("TACHE A FAIRE"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: db.ToDoList.length,
            itemBuilder: ((context, index) {
              return ToDoList(
                  nomTache: db.ToDoList[index][0],
                  tacheTermine: db.ToDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value!, index),
                  supprimer: (BuildContext) => supprimerTache(index),
                  newTime: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 7, minute: 15),
                    );
                  });
            })));
  }
}
