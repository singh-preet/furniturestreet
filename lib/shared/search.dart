import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate<String> {
  List search;
  SearchBar(this.search);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List showOnScreen = [];
    for (var item in search) {
      if (item['name'].toString().toLowerCase().contains(query)) {
        showOnScreen.add(item);
      }
    }
    return query.isEmpty?Container():ListView.builder(
        itemCount: showOnScreen.isEmpty ? 0 : showOnScreen.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: ListTile(
              leading: Image.network('https://images.unsplash.com/photo-1544457070-4cd773b4d71e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                width: 50,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text('Name'),
              trailing: Text('₹.5000.00' ,
                style: TextStyle(color: Colors.green),),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List showOnScreen = [];
    for (var item in search) {
      if (item['name'].toString().toLowerCase().contains(query)) {
        showOnScreen.add(item);
      }
    }
    return query.isEmpty?Container():ListView.builder(
        itemCount: showOnScreen.isEmpty ? 0 : showOnScreen.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: ListTile(
              leading: Image.network(
            'https://images.unsplash.com/photo-1544457070-4cd773b4d71e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                width: 50,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text('Name'),
              trailing: Text('₹10000.00' ,
                style: TextStyle(color: Colors.green),),
              onTap: (){
                print(index);
                print(showOnScreen[index]);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>null)
                );
              },
            ),
          );
        });
  }
}
