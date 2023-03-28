import 'dart:async';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatefulWidget {
  ToDoList(
      {Key? key,
      required this.nomTache,
      required this.tacheTermine,
      required this.onChanged,
      required this.supprimer,
      required this.newTime})
      : super(key: key);
  final String nomTache;
  final bool tacheTermine;
  final newTime;
  Function(bool?)? onChanged;
  Function(BuildContext)? supprimer;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Timer? countdownTimer;

  Duration myDuration = Duration(hours: 2, minutes: 10);

  late AnimateIconController c1;

  @override
  void initState() {
    // TODO: implement initState
    c1 = AnimateIconController();
    super.initState();
  }

  bool onEndIconPress(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("onEndIconPress called"),
        duration: Duration(seconds: 1),
      ),
    );
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("onStartIconPress called"),
        duration: Duration(seconds: 1),
      ),
    );
    return true;
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountdown());
  }

  void stopTimer() async {
    setState(() {
      countdownTimer!.cancel();
    });
  }

  void setCountdown() {
    setState(() {
      final seconds = myDuration.inSeconds - 1;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Padding(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: widget.supprimer,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: widget.tacheTermine,
                onChanged: widget.onChanged,
                activeColor: Colors.black,
              ),
              //nom de la tache
              Text(
                widget.nomTache,
                style: TextStyle(
                    decoration: widget.tacheTermine
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
