import 'package:flutter/material.dart';

class AdminOrderDetailsScreem extends StatefulWidget {
  const AdminOrderDetailsScreem({Key? key}) : super(key: key);

  @override
  _AdminOrderDetailsScreemState createState() =>
      _AdminOrderDetailsScreemState();
}

class _AdminOrderDetailsScreemState extends State<AdminOrderDetailsScreem> {
  DateTime? diliveryDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("1908"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 140,
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
                            height: 140,
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
                          Text("Quantity : 4"),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Dilivery Address"),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Text("320,hemkunk"),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Total item ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("4 "),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Pendding",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Shipping Charge",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("0 \u{20B9}"),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Pay Ammount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("44500 \u{20B9}"),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("Dilivery Date"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        diliveryDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2024));
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black)),
                        height: 50,
                        child: Center(
                          child: diliveryDate == null
                              ? const Text("Select Dilivery Date",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))
                              : Text(diliveryDate.toString().substring(0, 11),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF9c6d9d),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text("Confirm Order",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  height: 50,
                  child: const Center(
                    child: Text("Cancel Order",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
