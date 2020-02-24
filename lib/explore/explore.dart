import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:furniturestreet/itemList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Explore extends StatefulWidget {
  Explore();
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore>  with SingleTickerProviderStateMixin {

  TabController control;
  Map dataSofa, dataBed, dataDining, dataTable,dataChair, dataStorage, dataOffice, dataMat;
  var url='https://furniturestreet.in/MobileApi/products/';

  Future getSofa() async{
     http.Response response= await http.post(url,body: {'loc_id':"1", 'cat_id': '1', } );
    setState(() {
      dataSofa=json.decode(response.body);
    });
  }

  Future getBed() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'2'});
    setState(() {
      dataBed=json.decode(response.body);
    });
  }
  Future getDining() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'3'});
    setState(() {
      dataDining=json.decode(response.body);
    });
  }
  Future getTable() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'4'});
    setState(() {
      dataTable=json.decode(response.body);
    });
  }
  Future getChair() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'5'});
    setState(() {
      dataChair=json.decode(response.body);
    });
  }
  Future getStorage() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'6'});
    setState(() {
      dataStorage=json.decode(response.body);
    });
  }
  Future getOffice() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'7'});
    setState(() {
      dataOffice=json.decode(response.body);
    });
  }
  Future getMat() async{
    http.Response response=await http.post(url,body: {'loc_id':'1','cat_id':'8'});
    setState(() {
      dataMat=json.decode(response.body);
    });
  }

  @override
  void initState() {
    getSofa();
    getBed();
    getChair();
    getDining();
    getTable();
    getOffice();
    getStorage();
    getMat();
    control = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                child: RichText(
                  text: TextSpan(
                      text: 'Our ',
                      style: TextStyle(color: primary, fontSize: 30),
                      children: [
                        TextSpan(
                            text: 'Products',
                            style: TextStyle(color: Colors.grey[500]))
                      ]),
                ),
              ),
//              MaterialButton(onPressed: (){getBed();},child: Text('Click me'),)

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabBar(
              controller: control,
              isScrollable: true,
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: primary,
              labelColor: primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.5,

              tabs: <Tab>[
                Tab(
                  text: 'Sofas',
                ),
                Tab(
                  text: 'Beds',
                ),
                Tab(
                  text: 'Dining',
                ),
                Tab(
                  text: 'Tables',
                ),
                Tab(
                  text: 'Chairs',
                ),
                Tab(
                  text: 'Storage',
                ),
                Tab(
                  text: 'Office',
                ),
                Tab(
                  text: 'Mattresses',
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 220,
            child: dataSofa!=null &&dataSofa.isNotEmpty? TabBarView(
              children: <Widget>[
                dataSofa!=null &&dataSofa.isNotEmpty?  Test(dataList: dataSofa['products'],):Center(child: CircularProgressIndicator(),),
                dataBed!=null && dataBed.isNotEmpty? Test(dataList: dataBed['products'],):Center(child: CircularProgressIndicator(),),
                dataDining!=null && dataDining.isNotEmpty?  Test(dataList: dataDining['products'],):Center(child: CircularProgressIndicator(),),
                dataTable!=null && dataTable.isNotEmpty? Test(dataList: dataTable['products'],):Center(child: CircularProgressIndicator(),),
                dataChair!=null && dataChair.isNotEmpty? Test(dataList: dataChair['products'],):Center(child: CircularProgressIndicator(),),
                dataStorage!=null && dataStorage.isNotEmpty? Test(dataList: dataStorage['products'],):Center(child: CircularProgressIndicator(),),
                dataOffice!=null && dataOffice.isNotEmpty? Test(dataList: dataOffice['products'],):Center(child: CircularProgressIndicator(),),
                dataMat!=null && dataMat.isNotEmpty? Test(dataList: dataMat['products'],):Center(child: CircularProgressIndicator(),),
              ],
              controller: control,
            ):Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(primary),
            ),),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }
}
