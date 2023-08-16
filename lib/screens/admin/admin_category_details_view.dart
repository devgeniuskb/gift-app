import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/add_product.dart';
import 'package:gift_app/screens/admin/update_product.dart';
import 'package:lottie/lottie.dart';

class AdminCategoryDetailsView extends StatefulWidget {
  final String id;
  final String name;
  const AdminCategoryDetailsView(
      {Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminCategoryDetailsViewState createState() =>
      _AdminCategoryDetailsViewState();
}

class _AdminCategoryDetailsViewState extends State<AdminCategoryDetailsView> {
  List data = [];
  bool isLoader = false;
  void getData() async {
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot items = await firebaseFirestore
        .collection("category")
        .doc(widget.id)
        .collection("items")
        .get();
    data = items.docs;
    isLoader = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProductScreen(
                    id: widget.id,
                  )));
        },
        backgroundColor: const Color(0xFF9c6d9d),
        child: const Icon(Icons.add),
      ),
      body: isLoader == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9c6d9d),
              ),
            )
          : data.isEmpty
              ? Center(child: Lottie.asset("assets/image/no-data-found.json"))
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      height: 120,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  data[index]['image'],
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
                                data[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${data[index]['price']} \u{20B9}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF9c6d9d)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UpdateProduct(
                                          name: data[index]['name'],
                                          price: data[index]['price'],
                                          itemsId: data[index]['id'],
                                          categoryId: widget.id,
                                          image: data[index]['image'],
                                        )));
                              },
                              child: const Center(child: Icon(Icons.edit))),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    );
                  }),
    );
  }
}
