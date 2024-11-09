import 'package:hive/hive.dart';
import 'package:books_api/models/hive_local_book.dart';

class Boxes{

  static Box<HiveLocalBook> getHiveLocalBookBox() => Hive.box<HiveLocalBook>('books');

}