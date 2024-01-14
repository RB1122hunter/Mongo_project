import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  try {
    // Connect to MongoDB
    final db = await Db.create("mongodb://demo_user:saad123@ac-yg5ho3g-shard-00-00.cn6vrlk.mongodb.net:27017,ac-yg5ho3g-shard-00-01.cn6vrlk.mongodb.net:27017,ac-yg5ho3g-shard-00-02.cn6vrlk.mongodb.net:27017/?ssl=true&replicaSet=atlas-3kt6nf-shard-0&authSource=admin&retryWrites=true&w=majority");
    

    await db.open();

    // Run a query
    final salesOnApril4th = await db.collection('youtube').count({
      'date': {
        '\$gte': DateTime(2014, 4, 4),
        '\$lt': DateTime(2014, 4, 5),
      }
    });

    print('$salesOnApril4th sales occurred on April 4th, 2014.');

    // Run an aggregation
    final aggregationResult = await db.collection('youtube').aggregateToStream([
      {
        '\$match': {
          'date': {
            '\$gte': DateTime(2014, 1, 1),
            '\$lt': DateTime(2015, 1, 1),
          },
        },
      },
      {
        '\$group': {
          '_id': '\$item',
          'totalSaleAmount': {
            '\$sum': {'\$multiply': ['\$price', '\$quantity']}
          },
        },
      },
    ]).toList();

    print('Aggregation Result: $aggregationResult');

    // Close the database connection
    await db.close();
  } catch (e) {
    print('Error: $e');
  }
}
