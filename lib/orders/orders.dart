import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int currentStep = 0;
//  changeIsActive(index) {
//    if (currStep >= index) {
//      return true;
//    } else {
//      return false;
//    }
//  }

  List<Step> orderDetails() {
    return [
      Step(
          title: Text(
            'Track Your Order',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Expected Delivery Time'),
              Text('Delivery Date'),
            ],
          ),
          isActive: true),
      Step(
        title: Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        ),
        content: Text('Working'),
      ),
      Step(
        title: Text(
          'Buyback Details',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
        ),
        content: Text('in Progress'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 80,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 0, 0),
            child: Row(
              children: <Widget>[
                Text(
                  'Orders  ',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primary,
                      letterSpacing: 3),
                ),
                SizedBox(
                  child: Divider(
                    color: primary,
                    thickness: 2,
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                ),

              ],
            ),
          ),
        ),
        Stepper(
          physics: NeverScrollableScrollPhysics(),
          steps: orderDetails(),
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < orderDetails().length - 1) {
              setState(() {
                currentStep++;
              });
            } else {
              currentStep = 0;
            }
          },
          onStepCancel: () {
            if (currentStep > orderDetails().length) {
              setState(() {
                currentStep = currentStep - 1;
              });
            } else {
              setState(() {
                currentStep = 0;
              });
            }
          },
          onStepTapped: (i) {
            setState(() {
              currentStep = i;
            });
          },
        ),
      ],
    );
  }
}
