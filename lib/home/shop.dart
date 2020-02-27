import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:furniturestreet/shared/category.dart';
import 'package:furniturestreet/shared/item.dart';
import 'package:furniturestreet/shared/style.dart';
import '../shared/cart.dart';
import '../shared/search.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Map data ;
  List categoryList;
  List bannerList;
  List offerList;
  List rentProductsList;
  Future getData() async {
    var url = 'https://furniturestreet.in/MobileApi/home';
    http.Response response = await http.post(url, body: {'loc_id': '1'});
    setState(() {
      data = json.decode(response.body);
      categoryList=data['data'][0]['categories'];
      bannerList=data['data'][0]['banners'];
      offerList=data['data'][0]['offers'];
      rentProductsList=data['data'][0]['rent_products'];

//
//      print(data['data'][0]['categories'][1]['category_name']);
    });
//    print(data);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
//      data != null && data.isNotEmpty
//        ?
    ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Furniture Street',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Creates future home',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                  )
                ],
              ),
              Card(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey[600],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Search unique furniture...",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: SearchBar([]),
                        );
                        // getDataForSearch();
                      },
                    )),
                elevation: 5,
                color: Colors.white,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 20, color: primary),
                    ),
//              FlatButton(
//                child: Text('View All'),
//                onPressed: (){
//                  getData();
//                },
//              )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: data != null && data.isNotEmpty
                        ? categoryList.length
                        : 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return data != null && data.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  print(categoryList[index]
                                      ['category_id']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Category(
                                        name: categoryList
                                            [index]['category_name'],
                                        catId: categoryList
                                            [index]['category_id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: primary.withOpacity(0.1),
                                  height: 80,
                                  width: 130,
                                  child: Column(
                                    children: <Widget>[
                                      CachedNetworkImage(imageUrl:
                                        categoryList[index]
                                            ['image_url'],
                                        height: 60,
                                        width: 80,
                                      ),
                                      Text(categoryList[index]
                                          ['category_name']),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                color: primary.withOpacity(0.1),
                                height: 80,
                                width: 130,
                              ),
                            );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Today's Promo",
                      style: TextStyle(fontSize: 20, color: primary),
                    ),
//              FlatButton(
//                child: Text('View All'),
//                onPressed: null,
//              )
                  ],
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data != null && data.isNotEmpty
                      ? offerList.length
                      : 3,
                  itemBuilder: (context, index) {
                    return data != null && data.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                child: CachedNetworkImage(imageUrl:
                                  offerList[index]['image_url'],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: primary.withOpacity(0.5),
                              height: 100,
                              width: double.maxFinite,
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Trending Furniture",
                      style: TextStyle(fontSize: 20, color: primary),
                    ),
//              FlatButton(
//                child: Text('View All'),
//                onPressed: null,
//              )
                  ],
                ),
              ),
              Container(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data != null && data.isNotEmpty
                      ? bannerList.length
                      : 3,
                  itemBuilder: (context, index) {
                    return data != null && data.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Item()));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width - 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10),
                                  child: CachedNetworkImage(imageUrl:
                                    bannerList[index]
                                        ['image_url'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            color: primary.withOpacity(0.4),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Rented Products",
                      style: TextStyle(fontSize: 20, color: primary),
                    ),
//              FlatButton(
//                child: Text('View All'),
//                onPressed: null,
//              )
                  ],
                ),
              ),
              Container(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return data != null && data.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Category(
                                                name: data['data'][0]
                                                        ['categories'][index]
                                                    ['category_name'],
                                              )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: primary.withOpacity(0.1),
                                    height: 80,
                                    width: 130,
                                    child: CachedNetworkImage(imageUrl:
                                      rentProductsList[index]
                                          ['product_image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 120,
                              color: primary.withOpacity(0.4),
                            );
                    }),
              ),
            ],
          );
//        : Center(
//            child: CircularProgressIndicator(
//            valueColor: AlwaysStoppedAnimation<Color>(primary),
//          ));
  }
}
