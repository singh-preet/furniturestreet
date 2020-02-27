import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map> cartList = [
    {
      'name': 'Table',
      'price': '140',
      'image':
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
    },
    {
      'name': 'Chair',
      'price': '130',
      'image':
      'https://images.unsplash.com/photo-1562184552-997c461abbe6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
    },
    {
      'name': 'Dining Table',
      'price': '120',
      'image':
      'https://images.unsplash.com/photo-1519947486511-46149fa0a254?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
    },
    {
      'name': 'Table',
      'price': '110',
      'image':
      'https://images.unsplash.com/photo-1550226891-ef816aed4a98?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
    },
  ];

  double calculatePrice() {
    double total = 0;
    for (int i = 0; i < cartList.length; i++) {
      total = total + (int.parse(cartList[i]['price']));
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SHOPPING CART',
          style: TextStyle(color: primary),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_outline), onPressed: null)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartList.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: primary.withOpacity(0.5),
                                height: 150,
                                child: CachedNetworkImage(imageUrl:
                                  cartList[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    cartList[index]['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text('₹${cartList[index]['price']}'),
                                  Text(cartList.length.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Total Price:           ',
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                        children: [
                          TextSpan(
                              text: '₹' + calculatePrice().toString(),
                              style: TextStyle(color: Colors.black))
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
