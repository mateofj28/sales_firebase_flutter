import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sales_firebase_flutter/screens/create_sale_screen.dart';
import 'package:sales_firebase_flutter/services/firebase_services.dart';
import 'package:sales_firebase_flutter/widgets/dismissible_sales.dart';


class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {


  FirestoreService service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreService().getAllSales(), 
        builder: (context, snapshot){

          if (snapshot.hasData){
            List sales = snapshot.data!.docs;
        
            return ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, i){
                DocumentSnapshot document = sales[i];
                String docId = document.id;

                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                
                return DismissibleSales(
                  product: data['productName'],
                  value: data['price'].toString(),
                  onEdit: () {
                    // Handle edit action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateSaleScreen(sale: data, id: docId)
                      ),
                    );
                  },
                  onDelete: () {
                    // Handle delete
                    setState(() {
                      if (i >= 0 && i < sales.length) {
                        service.deleteSale(docId);
                        sales.removeAt(i);
                      }
                    });
                  },
                );
              }
            );
          } else {
            return const Text('No hay ventas');
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/create');
          print(" esto se ejecuta al regresar");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}