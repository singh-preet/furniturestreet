import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/cart.dart';
import 'package:http/http.dart' as http;
import 'package:furniturestreet/itemList.dart';
import 'search.dart';
import 'style.dart';
import 'dart:convert';

class Category extends StatefulWidget {
  final String name;
  final int catId;
  Category({this.name, this.catId});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Map data={};

  Future getProducts() async{
    Map formData = {
      'loc_id':"1",
      'cat_id': widget.catId.toString(),
    };
    var url='https://furniturestreet.in/MobileApi/products/';
    http.Response response= await http.post(url,body: formData );
    setState(() {
      data=json.decode(response.body);
      print(data['products'][0]);
    });

  }

@override
  void initState() {
    getProducts();
    super.initState();
  }

  void modalBottomSheetMenu(heading) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        ),
        context: context,
        builder: (builder) {
          return Container(
            width: MediaQuery.of(context).size.width-50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        heading,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Price Range',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Minimum',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,child: Divider(color: Colors.grey,),),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Maximum',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Item Filter',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  MaterialButton(onPressed: (){
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.local_shipping),
                      SizedBox(width: 10,),
                      Text('Free Shipping', style: TextStyle(fontWeight: FontWeight.w300),),
                    ],
                  ),minWidth: double.maxFinite,),
                  SizedBox(child: Divider(),),
                  MaterialButton(onPressed: (){},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(width: 10,),
                        Text('Discount', style: TextStyle(fontWeight: FontWeight.w300),),
                      ],
                    ),minWidth: double.maxFinite,),
                  SizedBox(child: Divider(),),
//                  Container(
//                    height: 60,
//                    child: ListView.builder(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                        itemCount: colorList.length,
//                        itemBuilder: (context, index){
//                      return Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: CircleAvatar(backgroundColor: Color(0xff922b21)),
//                      );
//                    }),
//                  ),
                  MaterialButton(onPressed: (){},
                  child: Text('Apply Filter', style: TextStyle(color: Colors.white),),color: primary,minWidth: double.maxFinite,)
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Test(dataList: data['products'],)
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                showSearch(
                                    context: context, delegate: SearchBar([]));
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                modalBottomSheetMenu('Filter');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.filter_list),
                                  Text('Filter'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                modalBottomSheetMenu('Sort');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.sort),
                                  Text('Sort'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                modalBottomSheetMenu('List');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.list),
                                  Text('List'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Divider(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
