import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/admin/admin_bottombar.dart';
import 'package:gift_app/widgets/alert_dialog.dart';
import 'package:gift_app/widgets/loader.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCategory extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  const UpdateCategory(
      {Key? key, required this.id, required this.name, required this.image})
      : super(key: key);

  @override
  _UpdateCategoryState createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  XFile? xfile;
  String image = "";
  String imageUrl = "";
  @override
  void initState() {
    imageUrl = widget.image;
    name.text = widget.name;
    super.initState();
  }

  void updateData() async {
    showIndiCator(context);
    if (image.isNotEmpty) {
      String ext = image.split(".").last;
      String imgpath =
          // ignore: prefer_interpolation_to_compose_strings
          DateTime.now().millisecondsSinceEpoch.toString() + "." + ext;
      if (!Uri.parse(imgpath).isAbsolute) {
        Reference reference = FirebaseStorage.instance.ref(imgpath);
        await reference.putFile(File(image));
        imageUrl = await reference.getDownloadURL();
      }
    }
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection("category").doc(widget.id).update({
      "name": name.text,
      "image": imageUrl,
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
          title: const Text("Update Category"),
          backgroundColor: const Color(0xFF9c6d9d),
          actions: [
            InkWell(
                onTap: () {
                  alertDialogView(
                      context: context,
                      title: "delete",
                      contet: "Are you sure to delete?",
                      yesPress: () async {
                        showIndiCator(context);
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        await firebaseFirestore
                            .collection("category")
                            .doc(widget.id)
                            .delete();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const AdminBottomBar()),
                            (route) => false);
                      },
                      noPress: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Icon(Icons.delete)),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text("Category Name"),
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
                    hintText: 'Category name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    xfile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
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
                      : SizedBox(
                          height: 300,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              )),
                        )),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  if (globalKey.currentState!.validate()) {
                    updateData();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF9c6d9d),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text("update Category",
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
