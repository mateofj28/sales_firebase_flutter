import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_firebase_flutter/delibery/services/users_services.dart';
import 'package:sales_firebase_flutter/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();          
  final _passwordController = TextEditingController();
  AuthServices _auth = AuthServices();

  clearData(){
    _emailController.text = '';
    _passwordController.text = '';
  }


  handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;
  
    if (email.isEmpty || password.isEmpty){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Please fill in all fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        )
      );
    } else {

      try{
        final value = await _auth.login(email, password);
        // ignore: use_build_context_synchronously
        context.read<UserServices>().getUser(value.uid);
        await _auth.getUserInfo(value.uid);

        clearData();

        if (email == "mfj@gmail.com" && password == "mfj123"){
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, "/homeAdmin");
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, "/homeClient");
        }

      } catch (err){
        showDialog(
          // ignore: use_build_context_synchronously
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: Text(err.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          )
        );  
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),

              Text("Enter your credential to login."),

              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Correo',
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  handleLogin();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?"),
                  SizedBox(width: 10,),


                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/createClient");  
                    },
                    child: Text(
                      "Sign Up", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                    ),
                  ),


                ],
              )


          ]
        ),
      ),
    );
  }
}