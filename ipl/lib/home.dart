

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Box team = Hive.box('team');

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var tea = team?.values.toList().reversed;
    var teams = List.from(tea!);
    print(tea);
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 74, 66, 66),
        child: ListView.builder(
            itemCount: teams?.length,
            itemBuilder: (context, index) {
              var image = teams?[index]['image'];
              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 300,
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('$image'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                teams?[index]['description'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 110, 114, 116),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
