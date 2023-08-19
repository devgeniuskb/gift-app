import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/screens/admin/category/add_category_screen.dart';
import 'package:gift_app/screens/admin/category/admin_category_details_view.dart';
import 'package:gift_app/screens/admin/category/update_category.dart';
import 'package:gift_app/screens/auth/login_screen.dart';
import 'package:gift_app/widgets/alert_dialog.dart';
import 'package:lottie/lottie.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List data = [];
  bool isLoader = false;
  void getData() async {
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot category =
        await firebaseFirestore.collection("category").get();
    data = category.docs;
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
        title: const Text("Admin"),
        backgroundColor: const Color(0xFF9c6d9d),
        actions: [
          InkWell(
              onTap: () {
                alertDialogView(
                    context: context,
                    title: "Logout",
                    contet: "Are you sure to logout?",
                    yesPress: () async {
                      await LocalStorage.instance.clear();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()),
                          (route) => false);
                    },
                    noPress: () {
                      Navigator.of(context).pop();
                    });
              },
              child: const Icon(Icons.logout)),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddCategoryScreen()));
        },
        backgroundColor: const Color(0xFF9c6d9d),
        child: const Icon(Icons.add),
      ),
      body: isLoader == true
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF9c6d9d)),
            )
          : data.isEmpty
              ? Center(child: Lottie.asset("assets/image/no-data-found.json"))
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminCategoryDetailsView(
                                  id: data[index]['id'],
                                  name: data[index]['name'],
                                )));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                                    data[index]['image'],
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: const Color(0xFF9c6d9d),
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    data[index]['name'],
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "${data[index]['count'].toString()} Items"),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UpdateCategory(
                                            id: data[index]['id'],
                                            image: data[index]['image'],
                                            name: data[index]['name'],
                                          )));
                                },
                                child: const Icon(Icons.edit)),
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
