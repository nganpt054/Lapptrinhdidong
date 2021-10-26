import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Group 1",
      home: MaterialBasic(),
    );
  }
}

class MaterialBasic extends StatefulWidget {
  const MaterialBasic({Key? key}) : super(key: key);

  @override
  _MaterialBasicState createState() => _MaterialBasicState();
}

class _MaterialBasicState extends State<MaterialBasic> {
  int count = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        leading: Icon(Icons.home, size: 30,color: Colors.amber),
        actions: [
          IconButton(onPressed: (){
            var snack = SnackBar(content: Row(
              children: [
                Icon(Icons.alarm, color: Colors.white,),
                Text("Xin chao")
              ],
            ));
            ScaffoldMessenger.of(context).showSnackBar(snack);

          }, icon: Icon(Icons.add_alert_rounded)),
          IconButton(onPressed: (){

          }, icon: Icon(Icons.login)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network("https://images.unsplash.com/photo-1631603296585-8e7e9a7a8f7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
            Image.network("https://images.unsplash.com/photo-1631544114506-c252206abbc6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80"),
            Text("Dem: $count", style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.call, size: 50, color: Colors.blue,)),
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.place, size: 50,color: Colors.red))
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            count++;
            print(count);
          });

        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
