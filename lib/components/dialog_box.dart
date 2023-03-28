import 'dart:ffi';

import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({ Key? key, required this.controller, required this.onCancel,required this.onNewTime, required this.onSave, this.newTime }) : super(key: key);
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  VoidCallback onNewTime;
  final newTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal[200],
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // InputText
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ajouter une nouvelle tâche"
              ),
            ),
            InkWell(
              onTap:onNewTime,
              child: Row(
                children: [
                  Icon(Icons.timelapse),
                  Text("Temps: ${newTime}"),
                ],
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
            //boutton annuler
            IconButton(onPressed: onCancel, icon: Icon(Icons.cancel)),
            //boutton sauvegarde
            IconButton(onPressed: onCancel, icon: Icon(Icons.save)),
              ],
            )
          ],
        ),
        height: 200,
      ),
    );
  }
}