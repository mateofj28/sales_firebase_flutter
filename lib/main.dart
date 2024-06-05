import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales_firebase_flutter/delibery/screens/create_repartidor.dart';
import 'package:sales_firebase_flutter/delibery/screens/home_admin.dart';
import 'package:sales_firebase_flutter/delibery/screens/menu_admin.dart';
import 'package:sales_firebase_flutter/screens/create_sale_screen.dart';
import 'package:sales_firebase_flutter/firebase_options.dart';
import 'package:sales_firebase_flutter/screens/create_user_screen.dart';
import 'package:sales_firebase_flutter/screens/login_screen.dart';
import 'package:sales_firebase_flutter/screens/sales_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  var menusDelibery = {
    '/homeAdmin': (_) => HomeAdminScreen(),
    '/menuAdmin': (_) => MenuAdminScreen(),
    '/createRepartidor': (_) => CreateRepartidorScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/homeAdmin',
      routes: menusDelibery,
    );
  }
  
}

