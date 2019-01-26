import 'package:flutter/material.dart';

class Menu extends StatefulWidget{
  static List<PopupMenuEntry<Choice>> itemList;

  Menu(List<Choice> options){
    itemList = options.map((Choice choice) {
      return PopupMenuItem<Choice>(
        value: choice,
        child: Text(choice.title),
      );
    }).toList();
  }

  List<PopupMenuEntry<Choice>> getItems(){
    return itemList;
  }

  @override
  State createState() => MenuState();
}
class MenuState extends State<Menu>{

  _select(Choice c) {
    c.callback();
  }

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton<Choice>(
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return widget.getItems();
      },
    ); 
  }
}

class Choice {
  const Choice({this.title, this.icon, this.callback});

  final Function callback;
  final String title;
  final IconData icon;
}