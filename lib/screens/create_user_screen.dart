import 'package:flutter/material.dart';
import 'package:sales_firebase_flutter/services/auth_services.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {


  final _emailController = TextEditingController();          
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  AuthServices _auth = AuthServices();

  clearData(){
    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';
  }


  handleSignIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
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

      if (password != confirmPassword){
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: const Text('Please password do not match'),
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
        return;
      }

      try{
        await _auth.createUser(email, password);

        // ignore: use_build_context_synchronously
        showDialog(
          // ignore: use_build_context_synchronously
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text('Info'),
            content: const Text('Nuevo cliente agregado'),
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

        clearData();

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

            const Text(
              "Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),

            Text("Create your account"),

            SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'password',
                  prefixIcon: Icon(Icons.lock),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Confirm password',
                  prefixIcon: Icon(Icons.lock),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 50,),

            ElevatedButton(
              onPressed: () {
                // Acción del botón
                handleSignIn();
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
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30,),

            const Text("Dont have an account?"),

            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: () {
                // Acción del botón
                Navigator.pushNamed(context, "/login");
              },
              style: ButtonStyle(
                
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blue, width: 2.0), // Borde azul de 1 píxel

                  ),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
            ),

              


              


          ]
        ),
      ),
    );

  }
}