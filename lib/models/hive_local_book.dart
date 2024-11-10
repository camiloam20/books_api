import 'package:hive/hive.dart';

part 'hive_local_book.g.dart';

@HiveType(typeId: 0)
class HiveLocalBook extends HiveObject {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? thumbnail;

  @HiveField(3)
  String? authors;

  @HiveField(4)
  String? publisher;

  @HiveField(5)
  String? publishedDate;

  @HiveField(6)
  String? categories;

  @HiveField(7)
  String? pageCount;

  @HiveField(8)
  String? averageRating;

  @HiveField(9)
  String? description;

}