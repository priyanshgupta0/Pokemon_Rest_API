import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Pokemon> getPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Pokemon.fromJson(data);
    }
    return Pokemon.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Pokemon>(
                future: getPokemons(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.results?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(
                                snapshot.data!.results![index].name.toString()),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.results![index].url
                                  .toString()),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
