import 'package:flutter/material.dart';
class DashBoardMenu {
  String title;
  String content;
  IconData icons;

  DashBoardMenu({required this.title,required this.content,required this.icons});

 factory DashBoardMenu.fromJson(Map<String, dynamic> json) {
    return DashBoardMenu( 
      title :json['title'],
      content :json['content'],
      icons: json['Icons']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['title'] = title;
    data['content'] = content;
    data['Icons'] = icons;
    return data;
  }
}