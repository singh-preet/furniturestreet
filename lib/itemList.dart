import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';
import 'shared/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  final List<dynamic> dataList;
//  final String prodId;
  Test({this.dataList});
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
//  List productDetails;
//  Future getProductDetails() async {
//    Map formData = { 'loc_id':'1'};
//    var url = 'https://furniturestreet.in/MobileApi/products/details/';
//    http.Response response = await http.post(url, body: formData);
//    setState(() {
//      productDetails = json.decode(response.body);
//    });
//    print(productDetails);
//  }

  @override
  void initState() {
//    getProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height / 2 - 120;
    double width = size.width / 2;
    return widget.dataList != null
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                itemCount: widget.dataList != null ? widget.dataList.length : 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: width / (height + 40),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Item(
                                productId: widget.dataList[index]['product_id'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(20.0,20.0)
                              )
                            ],
                            color: Colors.white,
                          ),
                          height: 170,
                          child: widget.dataList[index]['product_image'] != null
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CachedNetworkImage(imageUrl:
                                      widget.dataList[index]['product_image'],
                                      fit: BoxFit.fill,
                                    ),
//                              Text(
//                                  '${widget.dataList[index]['name'].substring(0, 10)}...',
//                                  style: TextStyle(color: Colors.grey[700])),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              '₹${widget.dataList[index]['discount_amt']}',
                                              style: TextStyle(
                                                  fontSize: 20, color: primary),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: RawMaterialButton(
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              shape: CircleBorder(),
                                              elevation: 2.0,
                                              fillColor: primary,
                                              splashColor:
                                                  primary.withOpacity(0.3),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    )
                                  ],
                                )
                              : Container(
                                  color: primary.withOpacity(0.3),
                                  height: 180,
                                ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: MediaQuery.of(context).size.height - 140,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                )),
              ),
            ),
          );
  }
}
