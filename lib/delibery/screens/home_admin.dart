import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pushNamed(context, '/menuAdmin');
          },
        ),
        title: Text("Admin mfj"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ventas",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Ver mas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[100]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ventas")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var sales = snapshot.data?.docs
                        .where((doc) => doc['estado'] == 'no adquirido')
                        .toList();

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sales?.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 300,
                            height: 200,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                      backgroundColor: Color(0xFF3996F7),
                                      foregroundColor: Colors.white,
                                      radius: 30,
                                      child: Icon(
                                          Icons.store_mall_directory_sharp)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(DateFormat('dd/MM/yyyy').format(
                                            sales![i]['fecha'].toDate()),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(sales![i]['estado']),
                                        SizedBox(width: 10),
                                        Icon(Icons.cancel_outlined)
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                        "Qty: ${sales[i]['productos'].length}"),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                            NumberFormat.currency(
                                                    locale: 'es_CO',
                                                    symbol: '\$',
                                                    decimalDigits: 0,
                                                    customPattern:
                                                        '\u00A4 #,##0')
                                                .format(
                                                    sales![i]['precioTotal']),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                        
                                        
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ventas Finalizadas",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Ver mas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[100]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ventas")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var sales = snapshot.data?.docs
                        .where((doc) => doc['estado'] == 'adquirido')
                        .toList();

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sales?.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 300,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: EdgeInsets.all(10),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.amber,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.black,
                                        size: 45,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("3 productos"),
                                    Text(
                                      "\$30.000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repartidores",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Ver mas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[100]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("usuarios").where('tipoUsuario', isEqualTo: 'repartidor')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var users = snapshot.data?.docs;

                    if (users!.length == 0) {
                      return Container(
                        child: const Column(
                          children: [
                            Icon(Icons.person),
                            Text("No hay repartidores")
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.purple,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(users[i]['nombre']),
                                
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
