import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/screens/add_address.dart';
import 'package:sales_firebase_flutter/delibery/screens/carrito_compras.dart';
import 'package:sales_firebase_flutter/delibery/screens/create_pizza.dart';
import 'package:sales_firebase_flutter/delibery/screens/create_repartidor.dart';
import 'package:sales_firebase_flutter/delibery/screens/home_admin.dart';
import 'package:sales_firebase_flutter/delibery/screens/home_client.dart';
import 'package:sales_firebase_flutter/delibery/screens/menu_admin.dart';
import 'package:sales_firebase_flutter/delibery/screens/menu_client.dart';
import 'package:sales_firebase_flutter/delibery/screens/my_orders.dart';
import 'package:sales_firebase_flutter/delibery/screens/segurity_page.dart';
import 'package:sales_firebase_flutter/delibery/screens/update_client.dart';
import 'package:sales_firebase_flutter/delibery/screens/venta_confirmada.dart';
import 'package:sales_firebase_flutter/delibery/services/pizza_services.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';
import 'package:sales_firebase_flutter/firebase_options.dart';
import 'package:sales_firebase_flutter/screens/create_user_screen.dart';
import 'package:sales_firebase_flutter/screens/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  var menusDelibery = {
    '/homeAdmin': (_) => const HomeAdminScreen(),
    '/menuAdmin': (_) => MenuAdminScreen(),
    '/createRepartidor': (_) => const CreateRepartidorScreen(),
    '/createPizza': (_) => const CreatePizzaScreen(),
    '/login': (_) => const LoginScreen(),
    '/createClient': (_) => const CreateUserScreen(),
    '/homeClient': (_) => const HomeClientScreen(),
    '/carritoCompras': (_) => const CarritoComprasScreen(),
    '/menuClient': (_) => MenuClientScreen(),
    '/createAddress': (_) => AddAddressScreen(),
    '/confirmSale': (_) => const VentaConfirmadaScreen(),
    '/updateClient': (_) => const UpdateClientScreen(),
    '/myOrders': (_) => const MyOrdersScreen(),
    '/segurity': (_) => SegurityScreen(),
  };


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PizzaServices()),
        ChangeNotifierProvider(create: (_) => UserServices()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: menusDelibery,
      ),
    );
  }
  
}

