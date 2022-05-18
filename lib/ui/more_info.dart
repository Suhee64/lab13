import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getapiproject/model/post.dart';
import 'dart:async';
import 'dart:convert';


Future<Post> negPost(int id) async {
  
  final res = await http.get(Uri.parse('http://192.168.1.106:8000/api/posts/${id}'));
  if (res.statusCode ==200){
    
  return Post.fromJson(jsonDecode(res.body));
  }else{
    throw Exception('Aldaatai bn');
  }
}


class MoreInfo extends StatefulWidget {
  final int id;
  const MoreInfo({ Key? key, required this.id}) : super(key: key);

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("delgerengui medeelel harah"),
      ),
      body: FutureBuilder(
        future: negPost(widget.id),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 6,
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data.id.toString()),
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(snapshot.data.title,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6))),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    snapshot.data.description,
                    style: 
                      TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Expanded(
                  child: Image.network(snapshot.data.p_image.toString())),
              ],
            ),
          );
          }else if (snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}