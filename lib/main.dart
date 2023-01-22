import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();
final baseUrl = "https://reqres.in/api/users";

Future<List> postUser(String name, String job)async{
  var formData = FormData.fromMap({
    "name": name,
    "job": job
  });
  
  var response = await dio.post(baseUrl,data: formData);
  List userList = [];
  
  if(response.statusCode == 201){
    userList.add(response.data);
    return userList;
  }
  else{
    return throw Exception();
  }
}


void main(){
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: postUser(nameController.text, jobController.text),
        builder: (context,snapshot){

          if(snapshot.hasError){
            return Center(child: Text("Error"),);

          }else if(snapshot.hasData){
            return Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter name"
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter job"
                      ),
                    ),
                    SizedBox(height: 10,),
                    
                    ElevatedButton(onPressed: (){
                      postUser(nameController.text, jobController.text);
                     print( postUser(nameController.text, jobController.text));
                    }, child: Text("Submit"))
                  ],
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

