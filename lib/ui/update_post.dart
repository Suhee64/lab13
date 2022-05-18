import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePost extends StatefulWidget {
  const UpdatePost({ Key? key }) : super(key: key);

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

Future updatePost(String title, String desc) async {
  
  final res = 
    await http.put(Uri.parse('http://192.168.1.106:8000/api/posts'), body: {
    "title": title,
    "description":desc,
    "p_image":"test.jpg",
    "user_id":"2",
      });
  if (res.statusCode ==200){
    print("nemegdsen");
  }else{
    throw Exception('Aldaatai bn');
  }
}


class _UpdatePostState extends State<UpdatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post oruulah"),
      ),
      body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title oruulah'
              ),
              controller: titleController,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'tailbar oruulah'
              ),
              controller: descController,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              updatePost(titleController.text,descController.text);
            }, child: Text("Post oruulah")),
          ],
        ),
      ),
     ),
    );
  }
}