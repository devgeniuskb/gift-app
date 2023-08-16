import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/add_product.dart';

class AdminCategoryDetailsView extends StatefulWidget {
  const AdminCategoryDetailsView({Key? key}) : super(key: key);

  @override
  _AdminCategoryDetailsViewState createState() =>
      _AdminCategoryDetailsViewState();
}

class _AdminCategoryDetailsViewState extends State<AdminCategoryDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Cake"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddProductScreen()));
        },
        backgroundColor: const Color(0xFF9c6d9d),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 120,
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
                        height: 120,
                        width: 120,
                        child: Image.network(
                          "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSHOFW8N1dyvn9ePx8BsZDoYN9Lye6g4Fx00oyiV_jR8-0qiwxYywRR7i7BTYsELLlXbkjjoJYpYP3_cNk3SVrAvlv9-Ks8mQ",
                          fit: BoxFit.fill,
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                 const  Column(
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
                      ), const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  ],
              ),
            );
          }),
   
    );
  }
}
