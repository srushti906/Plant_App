// // // import 'package:flutter/material.dart';
// // // import 'track_order.dart'; // Ensure the path to track_order.dart is correct

// // // final ThemeData peacockTheme = ThemeData(
// // //   primarySwatch: Colors.teal,
// // //   elevatedButtonTheme: ElevatedButtonThemeData(
// // //     style: ElevatedButton.styleFrom(
// // //       backgroundColor: Colors.teal, // Button background color
// // //       foregroundColor: Colors.white, // Button text color
// // //     ),
// // //   ),
// // // );

// // // class DeliveryInformationForm extends StatefulWidget {
// // //   final String selectedPaymentMethod;
// // //   final double totalPrice;

// // //   DeliveryInformationForm({required this.selectedPaymentMethod, required this.totalPrice});

// // //   @override
// // //   _DeliveryInformationFormState createState() => _DeliveryInformationFormState();
// // // }

// // // class _DeliveryInformationFormState extends State<DeliveryInformationForm> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   final _nameController = TextEditingController();
// // //   // final _birthdateController = TextEditingController();
// // //   final _addressController = TextEditingController();
// // //   final _cityController = TextEditingController();
// // //   final _pincodeController = TextEditingController();
// // //   final _emailController = TextEditingController();
// // //   final _phoneController = TextEditingController();

// // //   @override
// // //   void dispose() {
// // //     _nameController.dispose();
// // //     // _birthdateController.dispose();
// // //     _addressController.dispose();
// // //     _cityController.dispose();
// // //     _pincodeController.dispose();
// // //     _emailController.dispose();
// // //     _phoneController.dispose();
// // //     super.dispose();
// // //   }

// // //   void _submitForm() {
// // //     if (_formKey.currentState!.validate()) {
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(
// // //           builder: (context) => TrackOrderPage(
// // //             name: _nameController.text,
// // //             // birthdate: _birthdateController.text,
// // //            // address: _addressController.text,
// // //             city: _cityController.text,
// // //             pincode: _pincodeController.text,
// // //             email: _emailController.text,
// // //             phoneNumber: _phoneController.text,
// // //             paymentMethod: widget.selectedPaymentMethod,
// // //             totalPrice: widget.totalPrice,
// // //             deliveryAddress: _addressController.text, // Pass delivery address
// // //             upiStatus: 'Pending', // Default value for UPI status or set based on your logic
// // //           ),
// // //         ),
// // //       );
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           content: Text('Please fill out all required fields correctly.'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Theme(
// // //       data: peacockTheme,
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: Text('Delivery Information'),
// // //           backgroundColor: Theme.of(context).primaryColor,
// // //         ),
// // //         body: SingleChildScrollView(  // Add this to prevent overflow on smaller screens
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Form(
// // //               key: _formKey,
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     'Payment Method: ${widget.selectedPaymentMethod}',
// // //                     style: Theme.of(context).textTheme.headlineMedium,
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text(
// // //                     'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
// // //                     style: Theme.of(context).textTheme.headlineMedium,
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   TextFormField(
// // //                     controller: _nameController,
// // //                     decoration: InputDecoration(labelText: 'Name'),
// // //                     validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
// // //                   ),
                  
// // //                   // TextFormField(
// // //                   //   controller: _addressController,
// // //                   //   decoration: InputDecoration(labelText: 'Address'),
// // //                   //   validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
// // //                   // ),
// // //                   TextFormField(
// // //                     controller: _cityController,
// // //                     decoration: InputDecoration(labelText: 'City'),
// // //                     validator: (value) => value == null || value.isEmpty ? 'Please enter your city' : null,
// // //                   ),
                  
// // //                   TextFormField(
// // //                     controller: _pincodeController,
// // //                     decoration: InputDecoration(labelText: 'Pincode'),
// // //                     validator: (value) => value == null || value.isEmpty ? 'Please enter your pincode' : null,
// // //                   ),
// // //                   TextFormField(
// // //                     controller: _emailController,
// // //                     decoration: InputDecoration(labelText: 'Email'),
// // //                     validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
// // //                   ),
// // //                   TextFormField(
// // //                     controller: _phoneController,
// // //                     decoration: InputDecoration(labelText: 'Phone Number'),
// // //                     validator: (value) => value == null || value.isEmpty ? 'Please enter your phone number' : null,
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   ElevatedButton(
// // //                     onPressed: _submitForm,
// // //                     child: Text('Submit'),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ?? Colors.teal,
// // //                       foregroundColor: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}) ?? Colors.white,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'track_order.dart'; // Ensure the path to track_order.dart is correct

// // final ThemeData peacockTheme = ThemeData(
// //   primarySwatch: Colors.teal,
// //   elevatedButtonTheme: ElevatedButtonThemeData(
// //     style: ElevatedButton.styleFrom(
// //       backgroundColor: Colors.teal, // Button background color
// //       foregroundColor: Colors.white, // Button text color
// //     ),
// //   ),
// // );

// // class DeliveryInformationForm extends StatefulWidget {
// //   final String selectedPaymentMethod;
// //   final double totalPrice;

// //   DeliveryInformationForm({
// //     required this.selectedPaymentMethod,
// //     required this.totalPrice,
// //   });

// //   @override
// //   _DeliveryInformationFormState createState() =>
// //       _DeliveryInformationFormState();
// // }

// // class _DeliveryInformationFormState extends State<DeliveryInformationForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();

// //   String _city = '';
// //   String _address = '';
// //   String _pincode = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserAddress(); // Fetch address from Firestore when the form initializes
// //   }

// //   Future<void> _fetchUserAddress() async {
// //     try {
// //       User? user = FirebaseAuth.instance.currentUser;

// //       if (user != null) {
// //         DocumentSnapshot addressDoc = await FirebaseFirestore.instance
// //             .collection('user_addresses')
// //             .doc(user.uid)
// //             .get();

// //         if (addressDoc.exists) {
// //           setState(() {
// //             _city = addressDoc['city'] ?? '';
// //             _address = addressDoc['address'] ?? '';
// //             _pincode = addressDoc['pincode'] ?? '';
// //           });
// //         }
// //       }
// //     } catch (e) {
// //       print('Error fetching user address: $e');
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _phoneController.dispose();
// //     super.dispose();
// //   }

// //   // Fetch Order ID from Firestore
// //   Future<String?> _fetchOrderId() async {
// //     try {
// //       User? user = FirebaseAuth.instance.currentUser;
// //       if (user != null) {
// //         // Assuming you have an 'orders' collection where orderId is stored
// //         QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
// //             .collection('orders')
// //             .where('userId', isEqualTo: user.uid)
// //             .orderBy('created_at', descending: true)
// //             .limit(1) // Fetch the latest order if that's the goal
// //             .get();

// //         if (orderSnapshot.docs.isNotEmpty) {
// //           DocumentSnapshot latestOrder = orderSnapshot.docs.first;
// //           return latestOrder['orderId'];
// //         }
// //       }
// //     } catch (e) {
// //       print('Error fetching order ID: $e');
// //     }
// //     return null; // Return null if no order ID is found
// //   }

// //   void _submitForm() async {
// //     if (_formKey.currentState!.validate()) {
// //       String? orderId = await _fetchOrderId(); // Fetch the Order ID from Firestore

// //       if (orderId != null) {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => TrackOrderPage(
// //               name: _nameController.text,
// //               city: _city,
// //               pincode: _pincode,
// //               email: _emailController.text,
// //               phoneNumber: _phoneController.text,
// //               paymentMethod: widget.selectedPaymentMethod,
// //               totalPrice: widget.totalPrice,
// //               deliveryAddress: _address, // Pass delivery address
// //               upiStatus: 'Pending', // Default value for UPI status or set based on your logic
// //               orderId: orderId, // Pass the fetched Order ID
// //             ),
// //           ),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('No order ID found for the user.'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Please fill out all required fields correctly.'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: peacockTheme,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Delivery Information'),
// //           backgroundColor: Theme.of(context).primaryColor,
// //         ),
// //         body: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Payment Method: ${widget.selectedPaymentMethod}',
// //                     style: Theme.of(context).textTheme.headlineMedium,
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text(
// //                     'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
// //                     style: Theme.of(context).textTheme.headlineMedium,
// //                   ),
// //                   SizedBox(height: 20),
// //                   TextFormField(
// //                     controller: _nameController,
// //                     decoration: InputDecoration(labelText: 'Name'),
// //                     validator: (value) =>
// //                         value == null || value.isEmpty ? 'Please enter your name' : null,
// //                   ),
// //                   TextFormField(
// //                     controller: _emailController,
// //                     decoration: InputDecoration(labelText: 'Email'),
// //                     validator: (value) =>
// //                         value == null || value.isEmpty ? 'Please enter your email' : null,
// //                   ),
// //                   TextFormField(
// //                     controller: _phoneController,
// //                     decoration: InputDecoration(labelText: 'Phone Number'),
// //                     validator: (value) =>
// //                         value == null || value.isEmpty ? 'Please enter your phone number' : null,
// //                   ),
// //                   SizedBox(height: 20),
// //                   ElevatedButton(
// //                     onPressed: _submitForm,
// //                     child: Text('Submit'),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Theme.of(context)
// //                               .elevatedButtonTheme
// //                               .style
// //                               ?.backgroundColor
// //                               ?.resolve({}) ??
// //                           Colors.teal,
// //                       foregroundColor: Theme.of(context)
// //                               .elevatedButtonTheme
// //                               .style
// //                               ?.foregroundColor
// //                               ?.resolve({}) ??
// //                           Colors.white,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'track_order.dart'; // Ensure the path to track_order.dart is correct

// final ThemeData peacockTheme = ThemeData(
//   primarySwatch: Colors.teal,
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.teal, // Button background color
//       foregroundColor: Colors.white, // Button text color
//     ),
//   ),
// );

// class DeliveryInformationForm extends StatefulWidget {
//   final String selectedPaymentMethod;
//   final double totalPrice;

//   DeliveryInformationForm({
//     required this.selectedPaymentMethod,
//     required this.totalPrice,
//   });

//   @override
//   _DeliveryInformationFormState createState() => _DeliveryInformationFormState();
// }

// class _DeliveryInformationFormState extends State<DeliveryInformationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _quantityController = TextEditingController(); // Add quantity controller

//   String _city = '';
//   String _address = '';
//   String _pincode = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAddress(); // Fetch address from Firestore when the form initializes
//   }

//   Future<void> _fetchUserAddress() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         DocumentSnapshot addressDoc = await FirebaseFirestore.instance
//             .collection('user_addresses')
//             .doc(user.uid)
//             .get();

//         if (addressDoc.exists) {
//           setState(() {
//             _city = addressDoc['city'] ?? '';
//             _address = addressDoc['address'] ?? '';
//             _pincode = addressDoc['pincode'] ?? '';
//           });
//         }
//       }
//     } catch (e) {
//       print('Error fetching user address: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _quantityController.dispose(); // Dispose of quantity controller
//     super.dispose();
//   }

//   // Fetch Order ID from Firestore
//   Future<String?> _fetchOrderId() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
//             .collection('orders')
//             .where('userId', isEqualTo: user.uid)
//             .orderBy('created_at', descending: true)
//             .limit(1) // Fetch the latest order if that's the goal
//             .get();

//         if (orderSnapshot.docs.isNotEmpty) {
//           DocumentSnapshot latestOrder = orderSnapshot.docs.first;
//           return latestOrder['orderId'];
//         }
//       }
//     } catch (e) {
//       print('Error fetching order ID: $e');
//     }
//     return null; // Return null if no order ID is found
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       String? orderId = await _fetchOrderId(); // Fetch the Order ID from Firestore

//       if (orderId != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TrackOrderPage(
//               name: _nameController.text,
//               city: _city,
//               pincode: _pincode,
//               email: _emailController.text,
//               phoneNumber: _phoneController.text,
//               paymentMethod: widget.selectedPaymentMethod,
//               totalPrice: widget.totalPrice,
//               deliveryAddress: _address, // Pass delivery address
//               upiStatus: 'Pending', // Default value for UPI status or set based on your logic
//               orderId: orderId, // Pass the fetched Order ID
//                cartItems: cartItems,
//             //  quantity: int.tryParse(_quantityController.text) ?? 0, // Pass quantity
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('No order ID found for the user.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill out all required fields correctly.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: peacockTheme,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Delivery Information'),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Payment Method: ${widget.selectedPaymentMethod}',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(labelText: 'Name'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your name' : null,
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your email' : null,
//                   ),
//                   TextFormField(
//                     controller: _phoneController,
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your phone number' : null,
//                   ),
//                   TextFormField(
//                     controller: _quantityController,
//                     decoration: InputDecoration(labelText: 'Quantity'), // Add quantity field
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value == null || value.isEmpty || int.tryParse(value) == null
//                             ? 'Please enter a valid quantity' : null,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: Text('Submit'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context)
//                               .elevatedButtonTheme
//                               .style
//                               ?.backgroundColor
//                               ?.resolve({}) ??
//                           Colors.teal,
//                       foregroundColor: Theme.of(context)
//                               .elevatedButtonTheme
//                               .style
//                               ?.foregroundColor
//                               ?.resolve({}) ??
//                           Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'track_order.dart'; // Ensure the path to track_order.dart is correct

// final ThemeData peacockTheme = ThemeData(
//   primarySwatch: Colors.teal,
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.teal, // Button background color
//       foregroundColor: Colors.white, // Button text color
//     ),
//   ),
// );

// class DeliveryInformationForm extends StatefulWidget {
//   final String selectedPaymentMethod;
//   final double totalPrice;

//   DeliveryInformationForm({
//     required this.selectedPaymentMethod,
//     required this.totalPrice,
//   });

//   @override
//   _DeliveryInformationFormState createState() => _DeliveryInformationFormState();
// }

// class _DeliveryInformationFormState extends State<DeliveryInformationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _quantityController = TextEditingController(); // Add quantity controller

//   String _city = '';
//   String _address = '';
//   String _pincode = '';
//   List<Map<String, dynamic>> _cartItems = []; // Initialize cartItems

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAddress(); // Fetch address from Firestore when the form initializes
//     _fetchCartItems(); // Fetch cart items from Firestore
//   }

//   Future<void> _fetchUserAddress() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         DocumentSnapshot addressDoc = await FirebaseFirestore.instance
//             .collection('user_addresses')
//             .doc(user.uid)
//             .get();

//         if (addressDoc.exists) {
//           setState(() {
//             _city = addressDoc['city'] ?? '';
//             _address = addressDoc['address'] ?? '';
//             _pincode = addressDoc['pincode'] ?? '';
//           });
//         }
//       }
//     } catch (e) {
//       print('Error fetching user address: $e');
//     }
//   }

//   Future<void> _fetchCartItems() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//             .collection('carts')
//             .doc(user.uid)
//             .collection('items')
//             .get();

//         setState(() {
//           _cartItems = cartSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//         });
//       }
//     } catch (e) {
//       print('Error fetching cart items: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _quantityController.dispose();
//     super.dispose();
//   }

//   Future<String?> _fetchOrderId() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
//             .collection('orders')
//             .where('userId', isEqualTo: user.uid)
//             .orderBy('created_at', descending: true)
//             .limit(1)
//             .get();

//         if (orderSnapshot.docs.isNotEmpty) {
//           DocumentSnapshot latestOrder = orderSnapshot.docs.first;
//           return latestOrder['orderId'];
//         }
//       }
//     } catch (e) {
//       print('Error fetching order ID: $e');
//     }
//     return null; 
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       String? orderId = await _fetchOrderId(); 

//       if (orderId != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TrackOrderPage(
//               name: _nameController.text,
//               city: _city,
//               pincode: _pincode,
//               email: _emailController.text,
//               phoneNumber: _phoneController.text,
//               paymentMethod: widget.selectedPaymentMethod,
//               totalPrice: widget.totalPrice,
//               deliveryAddress: _address, 
//               upiStatus: 'Pending', 
//               orderId: orderId,
//               cartItems: _cartItems, 
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('No order ID found for the user.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill out all required fields correctly.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: peacockTheme,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Delivery Information'),
//           backgroundColor: Theme.of(context).primaryColor,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Payment Method: ${widget.selectedPaymentMethod}',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(labelText: 'Name'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your name' : null,
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your email' : null,
//                   ),
//                   TextFormField(
//                     controller: _phoneController,
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     validator: (value) =>
//                         value == null || value.isEmpty ? 'Please enter your phone number' : null,
//                   ),
//                   TextFormField(
//                     controller: _quantityController,
//                     decoration: InputDecoration(labelText: 'Quantity'), // Add quantity field
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                         value == null || value.isEmpty || int.tryParse(value) == null
//                             ? 'Please enter a valid quantity' : null,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: Text('Submit'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context)
//                               .elevatedButtonTheme
//                               .style
//                               ?.backgroundColor
//                               ?.resolve({}) ??
//                           Colors.teal,
//                       foregroundColor: Theme.of(context)
//                               .elevatedButtonTheme
//                               .style
//                               ?.foregroundColor
//                               ?.resolve({}) ??
//                           Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'track_order.dart'; // Ensure the path to track_order.dart is correct

final ThemeData peacockTheme = ThemeData(
  primarySwatch: Colors.teal,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal, // Button background color
      foregroundColor: Colors.white, // Button text color
    ),
  ),
);

class DeliveryInformationForm extends StatefulWidget {
  final String selectedPaymentMethod;
  final double totalPrice;

  DeliveryInformationForm({
    required this.selectedPaymentMethod,
    required this.totalPrice,
  });

  @override
  _DeliveryInformationFormState createState() => _DeliveryInformationFormState();
}

class _DeliveryInformationFormState extends State<DeliveryInformationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _city = '';
  String _address = '';
  String _pincode = '';
  List<Map<String, dynamic>> _plantItems = []; // Store plant information
  List<Map<String, dynamic>> _cartItems = []; // To store cart items

  @override
  void initState() {
    super.initState();
    _fetchUserAddress(); // Fetch address from Firestore when the form initializes
    _fetchCartItems(); // Fetch cart items from Firestore
  }

  Future<void> _fetchUserAddress() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot addressDoc = await FirebaseFirestore.instance
            .collection('user_addresses')
            .doc(user.uid)
            .get();

        if (addressDoc.exists) {
          setState(() {
            _city = addressDoc['city'] ?? '';
            _address = addressDoc['address'] ?? '';
            _pincode = addressDoc['pincode'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user address: $e');
    }
  }

  // Future<void> _fetchCartItems() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
  //          .collection('carts')
  //         .doc(user.uid) // Use the user ID to access their cart
  //         .collection('items')
  //         .get();

  //       List<String> plantIds = cartSnapshot.docs.map((doc) => doc['plantId'] as String).toList(); // Get plant IDs

  //       // Fetch plant information based on IDs
  //       _fetchPlantDetails(plantIds);
  //     }
  //   } catch (e) {
  //     print('Error fetching cart items: $e');
  //   }
  // }

  // Future<void> _fetchPlantDetails(List<String> plantIds) async {
  //   try {
  //     List<Map<String, dynamic>> plants = [];

  //     for (String plantId in plantIds) {
  //       DocumentSnapshot plantDoc = await FirebaseFirestore.instance
  //           .collection('plants')
  //           .doc(plantId)
  //           .get();

  //       if (plantDoc.exists) {
  //         plants.add(plantDoc.data() as Map<String, dynamic>);
  //       }
  //     }

  //     setState(() {
  //       _plantItems = plants; // Update the state with fetched plants
  //     });
  //   } catch (e) {
  //     print('Error fetching plant details: $e');
  //   }
  // }
Future<void> _fetchCartItems() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch the user's cart document
      DocumentSnapshot cartDoc = await FirebaseFirestore.instance
          .collection('carts')
          .doc(user.uid) // Use the user ID to access their cart
          .get();

      if (cartDoc.exists) {
        // Assuming the cart document contains fields with plantId and quantity
        Map<String, dynamic>? cartData = cartDoc.data() as Map<String, dynamic>?;

        List<Map<String, dynamic>> items = [];

        // Loop through the cart data to extract plantId and quantity
        cartData!.forEach((plantId, value) {
          int quantity = value['quantity'] ?? 1; // Default to 1 if quantity is not specified
          items.add({'plantId': plantId, 'quantity': quantity});
        });

        setState(() {
          _cartItems = items; // Update cartItems with the extracted data
        });

        // Fetch corresponding plant details based on the extracted plant IDs
        List<String> plantIds = items.map((item) => item['plantId'] as String).toList();
        await _fetchPlantDetails(plantIds);
      } else {
        print('Cart document does not exist for user: ${user.uid}');
      }
    }
  } catch (e) {
    print('Error fetching cart items: $e');
  }
}

Future<void> _fetchPlantDetails(List<String> plantIds) async {
  try {
    List<Map<String, dynamic>> plants = [];

    for (String plantId in plantIds) {
      DocumentSnapshot plantDoc = await FirebaseFirestore.instance
          .collection('plants')
          .doc(plantId)
          .get();

      if (plantDoc.exists) {
        final plantData = plantDoc.data() as Map<String, dynamic>?;
        if (plantData != null) {
          // Add plant data along with the quantity from the cart
          plants.add({
            'id': plantId,
            'name': plantData['name'] ?? 'Unknown Plant',
            'price': plantData['price'] ?? 0.0,
            'imageUrl': plantData['imageUrl'] ?? '',
            'quantity': _cartItems.firstWhere((item) => item['plantId'] == plantId)['quantity'], // Get quantity from cart
          });
        }
      } else {
        print('Plant document does not exist for ID: $plantId');
      }
    }

    setState(() {
      _plantItems = plants; // Update the state with fetched plants
    });
  } catch (e) {
    print('Error fetching plant details: $e');
  }
}

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String orderId = 'Your Order ID Logic'; // Implement your order ID logic

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackOrderPage(
            name: _nameController.text,
            city: _city,
            pincode: _pincode,
            email: _emailController.text,   
            phoneNumber: _phoneController.text,
            paymentMethod: widget.selectedPaymentMethod,
            totalPrice: widget.totalPrice,
            deliveryAddress: _address,
            upiStatus: 'Pending',
            orderId: orderId,
            cartItems: _plantItems, // Pass the plant items here
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill out all required fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: peacockTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delivery Information'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method: ${widget.selectedPaymentMethod}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your name' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your email' : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your phone number' : null,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Items in Cart:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ..._plantItems.map((plant) {
                    return ListTile(
                      title: Text(plant['name']), // Assuming your plant has a 'name' field
                      subtitle: Text('Price: \$${plant['price']}'), // Assuming your plant has a 'price' field
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.backgroundColor
                              ?.resolve({}) ?? Colors.teal,
                      foregroundColor: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.foregroundColor
                              ?.resolve({}) ?? Colors.white,
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
