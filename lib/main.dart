import 'package:flutter/material.dart';
import 'package:getapiproject/ui/all_post.dart';

void main(){
  runApp(AppMain());
}
class AppMain extends StatelessWidget {
  const AppMain({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo",
      home: Getpost(),
    );
  }
}