import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data;
    getHomePageData() async{
      var url = 'https://furniturestreet.in/MobileApi/home';
      http.Response response = await http.post(url, body: {'loc_id': '1'});
      setState(() {
        data = json.decode(response.body);
//      print(data['data'][0]['categories'][1]['category_name']);
      });
    }




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
