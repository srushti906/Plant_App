import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController(); // Email controller
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true; // Flag to toggle password visibility
  String? _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> _signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     final email = _emailController.text;
  //     final password = _passwordController.text;

  //     try {
  //       // Create user with email and password
  //       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
        
       
  //       // Save the username in Firestore or locally
  //       // Here, you could also store additional user information (like username) in Firestore

  //       // Handle sign-up success (e.g., navigate to sign-in page)
  //       print('Email: $email');
  //       print('Password: $password');
  //       Navigator.of(context).pushReplacementNamed('/sign-in'); // Navigate to sign-in page
  //     } catch (e) {
  //       // Handle errors
  //       setState(() {
  //         _errorMessage = e.toString();
  //       });
  //     }
  //   }
  // }
Future<void> _signUp() async {
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;  // Assuming you have a controller for the username

    try {
      // Create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Get the user UID
      final User? user = userCredential.user;

      // Save the username and email in Firestore
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Handle sign-up success (e.g., navigate to sign-in page)
      print('Email: $email');
      print('Password: $password');
      Navigator.of(context).pushReplacementNamed('/sign-in'); // Navigate to sign-in page
    } catch (e) {
      // Handle errors
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }
}


    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text('Sign Up'),
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow for a cleaner look
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.teal[400]),
                            filled: true,
                            fillColor: Colors.teal[50],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: Icon(Icons.lock, color: Colors.teal[400]),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.teal[400],
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.teal[50],
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController, // Email field added
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.teal[400]),
                            filled: true,
                            fillColor: Colors.teal[50],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text('Sign Up'),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/sign-in');
                          },
                          child: Text(
                            'Already have an account? Sign In',
                            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
