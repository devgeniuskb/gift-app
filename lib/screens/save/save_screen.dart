import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
       bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xFF9c6d9d),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              "Items",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Spacer(),
            Text(
              "2",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
     
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 180,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.black12,
                    blurRadius: 3,
                    spreadRadius: 1)
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 180,
                        width: 140,
                        child: Image.network(
                          "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSHOFW8N1dyvn9ePx8BsZDoYN9Lye6g4Fx00oyiV_jR8-0qiwxYywRR7i7BTYsELLlXbkjjoJYpYP3_cNk3SVrAvlv9-Ks8mQ",
                          fit: BoxFit.fill,
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Watch",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "890 \u{20B9}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xFF9c6d9d)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Free Shipping",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: const Color(0xFF9c6d9d),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: const Color(0xFF9c6d9d),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Image.asset(
                        "assets/icon/bookmark.png",
                        color: Colors.white,
                        height: 20,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
