import 'package:books_api/models/api_books_response.dart';
import 'package:flutter/material.dart';
import 'package:books_api/repository/books_api.dart';

class ApiBooksPage extends StatefulWidget {
  const ApiBooksPage({super.key});

  @override
  State<ApiBooksPage> createState() => _ApiBooksPageState();
}

class _ApiBooksPageState extends State<ApiBooksPage> {
  final BookApi _bookApi = BookApi();
  final TextEditingController _parametro = TextEditingController(text: "flutter"); // Valor inicial "flutter"
  List<Items> listBooks = <Items>[];

  Future<void> _getBooks() async {
    ApiBooksResponse results = await _bookApi.getBook(_parametro.text);

    setState(() {
      listBooks = results.items ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _getBooks(); // Realizar la búsqueda inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo gris oscuro
      body: Column(
        children: [
          // Mensaje de instrucciones para el usuario
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Busca un libro por título o autor, analízalos a detalle y añade un libro a tus favoritos!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Barra de búsqueda en la parte superior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _parametro,
                    style: const TextStyle(color: Colors.yellow),
                    autofocus: true,
                    onSubmitted: (_) => _getBooks(),
                    decoration: InputDecoration(
                      hintText: '¡Buscar un libro!',
                      hintStyle: const TextStyle(color: Colors.yellow),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.search, color: Colors.yellow),
                  onPressed: _getBooks,
                ),
              ],
            ),
          ),

          // Lista de libros
          Expanded(
            child: listBooks.isEmpty
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : ListView.builder(
              itemCount: listBooks.length,
              itemBuilder: (context, index) {
                final book = listBooks[index].volumeInfo;
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: book?.imageLinks?.thumbnail != null
                        ? Image.network(
                      book!.imageLinks!.thumbnail!,
                      fit: BoxFit.cover,
                      width: 50,
                    )
                        : const Icon(Icons.book, color: Colors.white),
                    title: Text(
                      book?.title ?? 'Sin título.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Autor@: ${book?.authors?.join(', ') ?? 'Desconocido'}\n'
                          'Fecha de publicación: ${book?.publishedDate ?? 'Desconocida'}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
