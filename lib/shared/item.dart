import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Item extends StatefulWidget {
  final int productId;
  Item({this.productId});
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Map data;
  int image = 0;
  Future getProdDetails() async {
    http.Response response = await http.post(
        'https://furniturestreet.in/MobileApi/products/details/',
        body: {'loc_id': '1', 'product_id': widget.productId.toString()});
    setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    getProdDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null || data.isEmpty
        ? Scaffold(
        body:Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primary),
          ),),)
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.arrow_back_ios,color: primary,),),
              title: Text(
                data['products'][0]['name'],
                style: TextStyle(fontSize: 20, color: primary),
              ),
              backgroundColor: Colors.white,
            ),
            body: ListView(
                    children: <Widget>[
                      Container(
                        child: CachedNetworkImage(imageUrl:
                          data['products'][0]['product_image'][image]['image'],
                          fit: BoxFit.fill,
                        ),
                        height: MediaQuery.of(context).size.height / 2.3,
                        width: double.maxFinite,
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(70, 8, 70, 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                data['products'][0]['product_image'].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      image = index;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    child: CachedNetworkImage(imageUrl:
                                      data['products'][0]['product_image']
                                          [index]['image'],
                                    ),
                                  ),);
                            },
                          ),
                        ),
                      ),
                      Text(
                        'Discounted Price- ₹${data['products'][0]['discount_amt']}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Actual Price- ₹${data['products'][0]['actual_amt']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Only ${data['products'][0]['products_left']} are left',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Features:',
                        style: TextStyle(fontSize: 20, color: primary),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              data['products'][0]['product_features'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(data['products'][0]
                                  ['product_features'][index]['value']),
                            );
                          }),
                      Text(
                        'Buyback offers:',
                        style: TextStyle(fontSize: 20, color: primary),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              data['products'][0]['buyback_offers'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(data['products'][0]['buyback_offers']
                                  [index]['offer_title']),
                            );
                          })
                    ],
                  ),);
  }
}
