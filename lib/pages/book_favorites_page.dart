import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import '../functions/book_details.dart';
import '../models/hive_local_book.dart';

class BookFavoritesPage extends StatefulWidget {
  const BookFavoritesPage({super.key});

  @override
  State<BookFavoritesPage> createState() => _BookFavoritesPageState();
}

class _BookFavoritesPageState extends State<BookFavoritesPage> {

  Widget _buildListView() {
    return ValueListenableBuilder<Box<HiveLocalBook>>(
      valueListenable: Boxes.getHiveLocalBookBox().listenable(),
      builder: (context, box, _) {
        final bookBox = box.values.toList().cast<HiveLocalBook>();
        return ListView.builder(
          itemCount: bookBox.length,
          itemBuilder: (BuildContext context, int index) {
            final book = bookBox[index];
            return Card(
              color: Colors.grey[850],
              child: ListTile(
                onTap: () => showBookDetails(context, hiveBook: book),
                leading: book.thumbnail != null
                    ? Image.network(
                  book.thumbnail!,
                  fit: BoxFit.cover,
                  width: 50,
                )
                    : const Icon(Icons.book, color: Colors.white),
                title: Text(
                  book.title ?? 'Sin título.',
                  style: const TextStyle(color: Colors.yellow),
                ),
                subtitle: Text(
                  'Autor@: ${book.authors}\n'
                      'Fecha de publicación: ${book.publishedDate ??
                      'Desconocida'}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Estos son tus libros favoritos. ¡Revísalos o eliminalos de tu lista!',
              style: TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: _buildListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

