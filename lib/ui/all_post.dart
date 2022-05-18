import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getapiproject/ui/add_post.dart';
import 'package:http/http.dart' as http;
import 'package:getapiproject/model/post.dart';
import 'package:getapiproject/ui/more_info.dart';


Future<List<Post>> getPost() async {
  
  final res = await http.get(Uri.parse('http://192.168.1.111:8000/api/posts/'));
  if (res.statusCode == 200){
    List data= json.decode(res.body);
  List<Post> posts = data.map((e) => new Post.fromJson(e)).toList();
  return posts;
  }else{
    throw Exception('Aldaatai bn');
  }
}

Future deletePost(int id) async {
  
  final res = await http.delete(Uri.parse('http://192.168.1.106:8000/api/posts/${id}'));
  if (res.statusCode ==200){
    print("deleted");
  }else{
    throw Exception('Aldaatai bn');
  }
}

class Getpost extends StatefulWidget {
  const Getpost({ Key? key }) : super(key: key);

  @override
  State<Getpost> createState() => _MysAppState();
}

class _MysAppState extends State<Getpost> {
  late Future<List<Post>> futureData;

  @override
  void initState() {
    super.initState();
   // futureData = getPost();
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter ListView'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(BuildContext ctx) => PostNemeh()));
            }, icon: Icon(Icons.add_box)),
          ],
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: getPost(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      elevation: 6,
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(snapshot.data[index].id.toString()),
                          backgroundColor: Colors.purple,
                        ),
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].description),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                MoreInfo(id: snapshot.data[index].id)));
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},icon: Icon(Icons.edit)),
                            IconButton(
                              onPressed: () {
                                deletePost(snapshot.data[index].id);
                              },icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }else if (snapshot.hasData){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }
          ),
        ),
      ),
    );
  }
}