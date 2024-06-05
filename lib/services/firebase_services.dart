import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_firebase_flutter/models/sale.dart';

class FirestoreService {

  final CollectionReference sales = FirebaseFirestore.instance.collection('delivery');


  Future<void> createSale(Sale sale){
    return sales.add({
      'productName':sale.productName,
      'price':sale.value,
      'client':sale.client,
      'paymentDate': sale.paymentDate,
      'paymentMethod':sale.paymentMethod, 
    });
  }

  Stream<QuerySnapshot> getAllSales(){
    return sales.snapshots();
  }

  Future<void> updateSale(Sale sale, id){
    return sales.doc(id).update({
      'productName':sale.productName,
      'price':sale.value,
      'client':sale.client,
      'paymentDate': sale.paymentDate,
      'paymentMethod':sale.paymentMethod, 
    });
  }

  Future<void> deleteSale(String docId){
    return sales.doc(docId).delete();
  }



}