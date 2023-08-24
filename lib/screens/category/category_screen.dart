import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/screens/category/category_details_screen.dart';
import 'package:lottie/lottie.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isLoader = false;
  List data = [];
  List items = [];
  void getData() async {
    isLoader = true;
    setState(() {});
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot res = await firebaseFirestore.collection("category").get();
    data = res.docs;
    QuerySnapshot posterRes =
        await firebaseFirestore.collection("poster").get();
    items = posterRes.docs;
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
        title: const Text("Category"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: isLoader == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9c6d9d),
              ),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((posterItem) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              color: const Color(0xFF9c6d9d),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: Image.network(
                                  posterItem['url'],
                                ).image,
                                fit: BoxFit.fill,
                              )),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                data.isEmpty
                    ? Center(
                        child: Lottie.asset("assets/image/no-data-found.json"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CategoryDetails(
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
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          "${data[index]['name']}",
                                          maxLines: 2,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("${data[index]['count']} Items"),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
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
              ],
            ),
    );
  }
}
