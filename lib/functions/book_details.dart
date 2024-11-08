import 'package:books_api/models/api_books_response.dart';
import 'package:flutter/material.dart';

void showBookDetails(BuildContext context, Items book, List<Items> favoriteBooks) {
  final bookInfo = book.volumeInfo;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[850],
        titlePadding: const EdgeInsets.all(10),
        title: Column(
          children: [
            Text(
              bookInfo?.title ?? 'Sin título',
              style: const TextStyle(color: Colors.yellow),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            if (bookInfo?.imageLinks?.thumbnail != null) ...[
              Center(
                child: Image.network(
                  bookInfo!.imageLinks!.thumbnail!,
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
              if (bookInfo?.authors != null) ...[
                const Text(
                  'Autor@: ',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookInfo?.authors?.join(', ') ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8.0),
              ],
              if (bookInfo?.publisher != null) ...[
                const Text(
                  'Editorial: ',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookInfo?.publisher ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8.0),
              ],
              if (bookInfo?.publishedDate != null) ...[
                const Text(
                  'Fecha de publicación: ',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookInfo?.publishedDate ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8.0),
              ],
              if (bookInfo?.categories != null) ...[
                const Text(
                  'Categorías: ',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookInfo?.categories?.join(', ') ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8.0),
              ],
              if (bookInfo?.pageCount != null) ...[
                const Text(
                  'Número de páginas: ',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text(
                  bookInfo?.pageCount?.toString() ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8.0),
              ],
              const Text(
                'Descripción: ',
                style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
              Text(
                bookInfo?.description ?? 'Sin descripción disponible.',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              favoriteBooks.add(book);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('"${bookInfo?.title}" agregado a favoritos.',style: const TextStyle(color: Colors.yellow))),
              );
            },
            child: const Text('Agregar a Favoritos', style: TextStyle(color: Colors.yellow)),
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
