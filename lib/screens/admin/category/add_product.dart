import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/admin_bottombar.dart';
import 'package:gift_app/widgets/loader.dart';
import 'package:gift_app/widgets/toast.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final String id;
  const AddProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  XFile? xfile;
  String image = "";
  void addData() async {
    if (image.isEmpty) {
      showToast(message: "select image..");
      return;
    }
    showIndiCator(context);
    String url = "";
    String ext = image.split(".").last;
    String imgpath =
        // ignore: prefer_interpolation_to_compose_strings
        DateTime.now().millisecondsSinceEpoch.toString() + "." + ext;
    if (!Uri.parse(imgpath).isAbsolute) {
      Reference reference = FirebaseStorage.instance.ref(imgpath);
      await reference.putFile(File(image));
      url = await reference.getDownloadURL();
    }
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String id = "items-${DateTime.now().millisecondsSinceEpoch.toString()}";
    DocumentSnapshot res =
        await firebaseFirestore.collection("category").doc(widget.id).get();
    Map resList = (res.data() as Map);
    int count = resList['count'];
    count++;
    await firebaseFirestore
        .collection("category")
        .doc(widget.id)
        .update({"count": count});
    await firebaseFirestore
        .collection("category")
        .doc(widget.id)
        .collection("items")
        .doc(id)
        .set({
      "name": name.text,
      "price": price.text,
      "image": url,
      "id" : id,
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AdminBottomBar()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
          backgroundColor: const Color(0xFF9c6d9d),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text("Product Name"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "reqiured..!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Product name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Product price"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: price,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "reqiured..!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Product price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  xfile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  image = xfile!.path;
                  setState(() {});
                },
                child: image.isNotEmpty
                    ? SizedBox(
                        height: 300,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(image),
                              fit: BoxFit.cover,
                            )),
                      )
                    : Container(
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add Image",
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(Icons.add)
                            ]),
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  if (globalKey.currentState!.validate()) {
                    addData();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF9c6d9d),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text("Add Product",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
