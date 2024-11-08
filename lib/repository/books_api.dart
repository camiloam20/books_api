import 'dart:convert';

import 'package:books_api/models/api_books_response.dart';
import 'package:http/http.dart' as http;

class BookApi{

  Future<ApiBooksResponse> getBook(String? parameter) async {
    final response =
        await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$parameter'));

    print("Resultado: ${response.body}");

    if (response.statusCode == 200){
      return ApiBooksResponse.fromJson(jsonDecode(response.body));
    } else
      throw Exception('Hubo una falla al cargar los libros.');
  }
}