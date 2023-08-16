import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  XFile? xfile;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
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
                xfile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                image = xfile!.path;
                setState(() {});
              },
              child: image != null
                  ? SizedBox(
                      height: 300,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(image!),
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
                            const SizedBox(
                              height: 8,
                            ),
                            const Icon(Icons.add)
                          ]),
                    ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                if (globalKey.currentState!.validate()) {}
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
    );
  }
}
