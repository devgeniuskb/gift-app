import 'package:flutter/material.dart';
import 'package:gift_app/screens/category/category_details_screen.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoryDetails()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 100,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black12,
                          blurRadius: 3,
                          spreadRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSHOFW8N1dyvn9ePx8BsZDoYN9Lye6g4Fx00oyiV_jR8-0qiwxYywRR7i7BTYsELLlXbkjjoJYpYP3_cNk3SVrAvlv9-Ks8mQ",
                            fit: BoxFit.fill,
                          ),
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Cake",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("22 Items"),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
