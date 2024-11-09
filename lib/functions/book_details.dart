import 'package:books_api/models/api_books_response.dart';
import 'package:books_api/models/hive_local_book.dart';
import 'package:flutter/material.dart';

import '../boxes.dart';

void showBookDetails(BuildContext context, {Items? apiBook, HiveLocalBook? hiveBook}) {
  final bookInfo = apiBook?.volumeInfo;

  final title = bookInfo?.title ?? hiveBook?.title ?? 'Sin título';
  final thumbnail = bookInfo?.imageLinks?.thumbnail ?? hiveBook?.thumbnail;
  final authors = bookInfo?.authors?.join(', ') ?? hiveBook?.authors ?? 'Autor@ no disponible.';
  final publisher = bookInfo?.publisher ?? hiveBook?.publisher ?? 'Editorial no disponible';
  final publishedDate = bookInfo?.publishedDate ?? hiveBook?.publishedDate ?? 'Fecha de publicación no disponible';
  final categories = bookInfo?.categories?.join(', ') ?? hiveBook?.categories ?? 'Categorías no disponibles';
  final pageCount = bookInfo?.pageCount?.toString() ?? hiveBook?.pageCount ?? 'Número de páginas no disponible';
  final String averageRating;
  if (bookInfo?.averageRating != null) {
    averageRating = '${bookInfo?.averageRating} / 5 (${bookInfo?.ratingsCount ?? 0} calificaciones)';
  } else {
    averageRating = (hiveBook?.averageRating ?? 'Sin rating');
  }
  final description = bookInfo?.description ?? hiveBook?.description ?? 'Sin descripción disponible';

  bool isFavorite = hiveBook != null;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[850],
        titlePadding: const EdgeInsets.all(10),
        title: Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.yellow),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            if (thumbnail != null) ...[
              Center(
                child: Image.network(
                  thumbnail,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Autor@: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(authors, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Editorial: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(publisher, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Fecha de publicación: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(publishedDate, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Categorías: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(categories, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Número de páginas: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(pageCount, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Rating: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(averageRating, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8.0),
              const Text('Descripción: ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              Text(description, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (isFavorite) {
                hiveBook.delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"$title" eliminado de favoritos.', style: const TextStyle(color: Colors.red))),
                );
              } else {
                _saveBookInFavorites(context, apiBook!); // Pasar el context aquí
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"$title" agregado a favoritos.', style: const TextStyle(color: Colors.yellow))),
                );
              }
            },
            child: Text(
              isFavorite ? 'Eliminar de Favoritos' : 'Agregar a Favoritos',
              style: const TextStyle(color: Colors.yellow),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.yellow)),
          ),
        ],
      );
    },
  );
}

void _saveBookInFavorites(BuildContext context, Items book) {
  final bookInfo = book.volumeInfo;

  var hiveLocalBook = HiveLocalBook()
    ..id = book.id
    ..title = bookInfo?.title ?? 'Sin título'
    ..thumbnail = bookInfo?.imageLinks?.thumbnail ?? ''
    ..authors = bookInfo?.authors?.join(', ') ?? 'Autor@ no disponible'
    ..publisher = bookInfo?.publisher ?? 'Editorial no disponible'
    ..publishedDate = bookInfo?.publishedDate ?? 'Fecha no disponible'
    ..categories = bookInfo?.categories?.join(', ') ?? 'Categorías no disponibles'
    ..pageCount = bookInfo?.pageCount?.toString() ?? 'Número de páginas no disponible'
    ..averageRating = bookInfo?.averageRating != null
        ? '${bookInfo?.averageRating} / 5 (${bookInfo?.ratingsCount ?? 0} calificaciones)'
        : 'Sin rating'
    ..description = bookInfo?.description ?? 'Descripción no disponible';

  final box = Boxes.getHiveLocalBookBox();

  bool isBookAlreadyInFavorites = box.values.any((bookInBox) => bookInBox.id == hiveLocalBook.id);

  if (isBookAlreadyInFavorites) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${hiveLocalBook.title}" ya está en favoritos.', style: const TextStyle(color: Colors.red))),
    );
  } else {
    box.add(hiveLocalBook);
  }
}

class ParametroProvider with ChangeNotifier {
  TextEditingController _parametro = TextEditingController(text: "flutter");

  TextEditingController get parametro => _parametro;

  void updateParametro(String newValue) {
    _parametro.text = newValue;
    notifyListeners();
  }
}

