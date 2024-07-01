import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';

import 'package:intl/intl.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis ordenes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: context.watch<PizzaServices>().salesFiltered.length,
        itemBuilder: (context, index) {
          var sales = context.read<PizzaServices>().salesFiltered;

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
                    child: Icon(Icons.store_mall_directory_sharp)
                  ),
                ),

                SizedBox(width: 20,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text(sales[index]['metodoPago'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text(sales[index]['estado']),
                        SizedBox(width: 10),
                        Icon(Icons.cancel_outlined)
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("Qty: ${sales[index]['productos'].length}"),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0, customPattern: '\u00A4 #,##0').format(sales[index]['precioTotal']), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                        SizedBox(width: 60),
                        Text(DateFormat('dd/MM/yyyy').format(sales[index]['fecha'].toDate())),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );

        },
      ),
    );
  }
}