import 'package:flutter/material.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class WebviewPage extends StatelessWidget {
   final String title, url;
   WebviewPage({this.title, this.url});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text(title, style: TextStyle(color: primary),) ,backgroundColor: Colors.white,),
       body: WebView(initialUrl: url,),
     );
   }
 }
