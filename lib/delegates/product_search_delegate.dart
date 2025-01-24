import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/models/product.dart';

class ProductSearchDelegate extends SearchDelegate<ProductSearchData?> {
  final ProductModel model;

  ProductSearchDelegate({required this.model});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // If the query is already empty, close the search.
          if (query.isEmpty) {
            close(context, null);
          }
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => context.pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: model.search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data![index].name),
              onTap: () {
                close(
                  context,
                  snapshot.data![index],
                );
              },
            ),
          );
        } else {
          return Center(
            child: const Text('loading'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: model.search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data![index].name),
              onTap: () {
                close(
                  context,
                  snapshot.data![index],
                );
              },
            ),
          );
        } else {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
