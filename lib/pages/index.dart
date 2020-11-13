import 'dart:convert';

import 'package:antas_test/pages/user.dart';
import 'package:antas_test/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class User {
    final String fullName;
    final String email;
    final String url;
  User(this.fullName, this.email, this.url);  
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://randomuser.me/api/?results=50";
    var response = await http.get(url);
    // print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['results'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      isLoading = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("List of Users"),
      ),
      body: getBody(),

    );
  }


  Widget getBody() {
    if(users.contains(null) || users.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primary),));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
      return getUserCard(users[index]);
    });
  }

  Widget getUserCard(userItem) {
    var fullName = userItem['name']['title']+" "+userItem['name']['first']+" "+userItem['name']['last'];
    var email = userItem['email'];
    var profileUrl = userItem['picture']['large'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
              Navigator.push(context, 
              new MaterialPageRoute(builder: (context) => UserPage(User(fullName,email,profileUrl))));
          },
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(23),
                  image: DecorationImage(
                    image: NetworkImage(profileUrl),
                    fit: BoxFit.cover, 
                  )
                )
              ),
            SizedBox(width: 30, ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(fullName, style: TextStyle(fontSize: 17), overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10, ),
                Text(email, style: TextStyle(fontSize: 12, color: Colors.grey)),
               

              ]
            )
          ],
          )
        ),
      ),
    );
  }
}