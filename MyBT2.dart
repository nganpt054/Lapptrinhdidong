// 1. Fetcha data
// 2. Show product
// 3. Có nút chọn sản phẩm
// 4. Nhấn nút thì show dialog nhập số lượng
// 5. Đồng ý, bỏ qua
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class MyBT2 extends StatelessWidget {
  const MyBT2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCart(),
    );
  }
}

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  late Future<List<Product>> lsProduct;

  int count = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsProduct = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("KN Shop"),
      ),
      body: FutureBuilder(
        future: lsProduct,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasData)
          {
            var data = snapshot.data as List<Product>;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 400,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index)
                {
                  Product p = data[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(p.image, height: 200, width: 150,),
                        Text(p.title),
                        Text("Giá: "+p.price.toString(),style: TextStyle(fontSize: 18,color: Colors.orange)),
                        //Text("Description: "+p.description),
                        //Text("Category: "+p.category),
                        Text("Rate:" +p.rate.toString()),
                        Text("Count: "+p.count.toString()),
                        ElevatedButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)
                                  {
                                    return AlertDialog(
                                      content: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                                onPressed: (){
                                                  setState(() {
                                                    count--;
                                                    print(count);
                                                  });
                                                },
                                                child: Text("-",style: TextStyle(fontSize: 35,color: Colors.orange))
                                            ),
                                            Text("$count"),
                                            ElevatedButton(
                                                onPressed: (){
                                                  setState(() {
                                                    count++;
                                                    print(count);
                                                  });
                                                },
                                                child: Text("+",style: TextStyle(fontSize: 35,color: Colors.orange))
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Icon(Icons.shopping_cart_rounded)
                        ),
                      ],
                    ),
                  );
                }
            );
          }
          else
          {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final double count;

  Product({required this.id,required this.title,required this.price,required this.description,required this.category,required this.image, required this.rate, required this.count});


  static Future<List<Product>> fetchData() async {
    String url = "https://fakestoreapi.com/products?limit=100";
    var client = http.Client();
    //lấy dữ liệu về
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = response.body;
      var jsonData = jsonDecode(result); //.cast<List<Map<String, dynamic>>>();
      //Xem kiểu dữ liệu lấy về là gì
      // print(result.runtimeType);
      // print(jsonData.runtimeType);
      // print(jsonData[0].runtimeType);
      // print(jsonData[0]);
      List<Product> ls = [];
      for(var item in jsonData)
      {
        Product p = new Product(
          id: item['id'],
          title: item['title'],
          price: double.parse(item['price'].toString()),
          description: item['description'],
          category: item['category'],
          image: item['image'],
          rate: double.parse(item['rating']['rate'].toString()),
          count: double.parse(item['rating']['count'].toString()),
        );
        ls.add(p);
      }
      return ls;
    }
    else
    {
      throw Exception("Lỗi lấy dữ liệu: ${response.statusCode}");
    }
  }
}

