import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongoproj/dbHelper/constant.dart';

 

class MongoDatabase {
  static connect() async {
    try {
      var db = await Db.create(MONGO_CONN_URL);
      await db.open();
      inspect(db);
      
      var status = db.serverStatus();
      print(status);

      var collection = db.collection("youtube");
      await collection.insertOne({'item': 'saad', 'price': 10, 'quantity': 5, 'date': "new Date('2016-02-06T20:20:13Z')"});

      print(await collection.find().toList());
      print("hello");
    } catch (e) {
      print("An error occurred: $e");
      // You can handle the error in a way that makes sense for your application.
    }
  }
}
