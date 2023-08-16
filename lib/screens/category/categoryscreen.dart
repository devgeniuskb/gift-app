import 'package:flutter/material.dart';

import 'category_details_screen.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List data = [
    {
      "name": "Gifts",
      "image": "assets/v1.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Combos",
      "image": "assets/v2.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Cakes",
      "image": "assets/v3.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Plants",
      "image": "assets/v4.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Personalised",
      "image": "assets/v5.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Choclates",
      "image": "assets/v6.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Flower",
      "image": "assets/v7.jpeg",
      "des": "view Collection",
    },
    {
      "name": "Home Decoration",
      "image": "assets/v3.jpeg",
      "des": "view Collection",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryDetails()));
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5, 5),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Row(children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset(data[index]['image']),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]['name'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(data[index]['des'],
                          style: const TextStyle(
                            fontSize: 13,
                          )),
                    ],
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
