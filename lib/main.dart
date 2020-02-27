 import 'package:flutter/material.dart';
import 'package:furniturestreet/explore/explore.dart';
import 'package:furniturestreet/home/shop.dart';
import 'package:furniturestreet/orders/orders.dart';
import 'package:furniturestreet/profile/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniturestreet/signin/signup.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:furniturestreet/signin/signup.dart';
import 'shared/style.dart';

Future main() async {

  runApp(
    MaterialApp(
      home: Signup(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primary,
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: primary, ),)
      ),
    ),
  );
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  Hive.init(path);

var homePageBox = await Hive.openBox('homePageBox');
//var explorePageBox = await Hive.openBox('explorePageBox');

homePageBox.put("demoList", [1,2,3,4,5,6,7,8,9,0]);
}

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    var box = Hive.box('homePageBox');
    print(box.get("demoList"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: TabBar(
        isScrollable: false,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.home,
            ),
          ),
          Tab(
            icon: Icon(Icons.explore),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.shippingFast),
          ),
          Tab(
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1554780336-390462301acf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80'),
            ),
          ),
        ],
        indicatorColor: Colors.grey[100],
        labelColor: primary,
        unselectedLabelColor: Colors.grey[400],
        controller: _controller,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          Shop(),
          Explore(),
          Orders(),
          Profile(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    Hive.close();
    super.dispose();
  }
}
