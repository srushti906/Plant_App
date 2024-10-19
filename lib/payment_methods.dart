
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'track_order.dart'; // Ensure this is the correct path to the TrackOrderPage

// class PaymentMethodsPage extends StatefulWidget {
//   final double totalPrice;

//   PaymentMethodsPage({required this.totalPrice});

//   @override
//   _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
// }

// class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String _selectedPaymentMethod = '';
//   String _phoneNumber = '';
//   bool _isPhoneNumberVerified = false;
//   String _upiStatus = 'Pending';
//   bool _isPaymentSuccessful = false;

//   // User Address Info
//   String _city = '';
//   String _address = '';
//   String _pincode = '';
//   String _userName = '';
//   String _userEmail = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//     _fetchUserAddress(); // Fetch user address when page initializes
//   }

//   Future<void> _fetchUserData() async {
//     try {
//       User? user = _auth.currentUser;

//       if (user != null) {
//         String userId = user.uid;
//         DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

//         if (userDoc.exists) {
//           setState(() {
//             _userName = userDoc['username'] ?? '';
//             _userEmail = userDoc['email'] ?? '';
//           });
//         }
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }

//   Future<void> _fetchUserAddress() async {
//     try {
//       User? user = _auth.currentUser;

//       if (user != null) {
//         String userId = user.uid;
//         DocumentSnapshot addressDoc = await _firestore.collection('user_addresses').doc(userId).get();

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

 
//     Future<String?> _saveOrderDetails() async {
//   try {
//     User? user = _auth.currentUser;

//     if (user != null) {
//       String userId = user.uid;
//       String orderId = _firestore.collection('orders').doc().id;

//       await _firestore.collection('orders').doc(orderId).set({
//         'orderId': orderId,
//         'userId': userId,
//         'username': _userName,
//         'email': _userEmail,
//         'paymentMethod': _selectedPaymentMethod,
//         'deliveryAddress': _address, // Use address from user_address
//         'phoneNumber': _phoneNumber,
//         'upiStatus': _upiStatus,
//         'totalPrice': widget.totalPrice,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Order details saved successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       return orderId;  // Return the orderId
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('User not logged in!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return null;
//     }
//   } catch (e) {
//     print('Error saving order details: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error saving order details.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return null;
//   }
// }

//   void _verifyPhoneNumber() {
//     setState(() {
//       _isPhoneNumberVerified = true; // Assume the OTP is always correct for demo purposes
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Phone number verified successfully!'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _verifyUPIPayment() {
//     setState(() {
//       _upiStatus = 'Done';
//       _isPaymentSuccessful = true;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('UPI Payment successful!'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _showPaymentForm() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 8,
//           backgroundColor: Colors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _selectedPaymentMethod,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal[800],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 if (_selectedPaymentMethod == 'Cash on Delivery') _buildCashOnDeliveryForm(),
//                 if (_selectedPaymentMethod == 'UPI Transaction') _buildUPITransactionForm(),
//                 SizedBox(height: 20),
//                 _buildProceedButton(context),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPaymentOptions() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 12.0,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildPaymentOptionTile(
//             icon: Icons.money_off,
//             title: 'Cash on Delivery',
//             method: 'Cash on Delivery',
//           ),
//           Divider(),
//           _buildPaymentOptionTile(
//             icon: Icons.payment,
//             title: 'UPI Transaction',
//             method: 'UPI Transaction',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentOptionTile({
//     required IconData icon,
//     required String title,
//     required String method,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.all(16),
//       leading: Icon(
//         icon,
//         color: _selectedPaymentMethod == method ? Colors.green[600] : Colors.teal[400],
//       ),
//       title: Text(title),
//       tileColor: _selectedPaymentMethod == method ? Colors.green[100] : Colors.white,
//       onTap: () {
//         setState(() {
//           _selectedPaymentMethod = method;
//         });
//         _showPaymentForm();
//       },
//     );
//   }

//   Widget _buildCashOnDeliveryForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
        
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'Phone Number',
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.all(12),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: (value) {
//             _phoneNumber = value;
//           },
//         ),
//         SizedBox(height: 10),
//         if (!_isPhoneNumberVerified)
//           ElevatedButton(
//             onPressed: _verifyPhoneNumber,
//             child: Text('Verify Phone Number'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             ),
//           ),
//         if (_isPhoneNumberVerified)
//           Icon(
//             Icons.check_circle,
//             color: Colors.green,
//             size: 40,
//           ),
//       ],
//     );
//   }

//   Widget _buildUPITransactionForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
      
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'UPI ID',
//             hintText: 'your-upi-id@bank',
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.all(12),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: (value) {
//             // Handle UPI ID input
//           },
//         ),
//         SizedBox(height: 10),
//         Image.asset(
//           'assets/images/qr.png',
//           height: 150,
//         ),
//         SizedBox(height: 10),
//         Text('Scan the QR code to make a payment.'),
//         ElevatedButton(
//           onPressed: _verifyUPIPayment,
//           child: Text('Check UPI Payment Status'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.teal,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         ),
//         if (_isPaymentSuccessful)
//           Icon(
//             Icons.check_circle,
//             color: Colors.green,
//             size: 40,
//           ),
//       ],
//     );
//   }

  
// Widget _buildProceedButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () async {
//       if (_selectedPaymentMethod.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please select a payment method.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else if (_selectedPaymentMethod == 'Cash on Delivery' && _phoneNumber.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please fill in the phone number.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else if (_selectedPaymentMethod == 'UPI Transaction' && !_isPaymentSuccessful) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please complete the UPI payment.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else {
//         String? orderId = await _saveOrderDetails();

//         if (orderId != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TrackOrderPage(
//                 paymentMethod: _selectedPaymentMethod,
//                 deliveryAddress: _address,
//                 phoneNumber: _phoneNumber,
//                 totalPrice: widget.totalPrice,
//                 upiStatus: _upiStatus,
//                 name: _userName,
//                 city: _city,
//                 email: _userEmail,
//                 pincode: _pincode,
//                 orderId: orderId,  // Pass the orderId to TrackOrderPage
                
//               ),
//             ),
//           );
//         }
//       }
//     },
//     child: Text('Confirm and Proceed'),
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.teal,
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: AppBar(
//             title: Text('Payment Methods'),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             centerTitle: true,
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'GREEN SQUARE',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal[800],
//                 ),
//               ),
//               SizedBox(height: 20),
//               _buildPaymentOptions(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // Widget _buildProceedButton(BuildContext context) {
//   //   return ElevatedButton(
//   //     onPressed: () async {
//   //       if (_selectedPaymentMethod.isEmpty) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('Please select a payment method.'),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //       } else if (_selectedPaymentMethod == 'Cash on Delivery' &&
//   //           _phoneNumber.isEmpty) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('Please fill in the phone number.'),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //       } else if (_selectedPaymentMethod == 'UPI Transaction' && !_isPaymentSuccessful) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('Please complete the UPI payment.'),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //       } else {
//   //         await _saveOrderDetails();

//   //         Navigator.push(
//   //           context,
//   //           MaterialPageRoute(
//   //             builder: (context) => TrackOrderPage(
//   //               paymentMethod: _selectedPaymentMethod,
//   //               deliveryAddress: _address,
//   //               phoneNumber: _phoneNumber,
//   //               totalPrice: widget.totalPrice,
//   //               upiStatus: _upiStatus,
//   //               name: _userName,
//   //               city: _city,
//   //               email: _userEmail,
//   //               pincode: _pincode,
//   //             ),
//   //           ),
//   //         );
//   //       }
//   //     },
//   //     child: Text('Confirm and Proceed'),
//   //     style: ElevatedButton.styleFrom(
//   //       backgroundColor: Colors.teal,
//   //       foregroundColor: Colors.white,
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(8),
//   //       ),
//   //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//   //     ),
//   //   );
//   // }
//    // Future<void> _saveOrderDetails() async {
//   //   try {
//   //     User? user = _auth.currentUser;

//   //     if (user != null) {
//   //       String userId = user.uid;
//   //       String orderId = _firestore.collection('orders').doc().id;

//   //       await _firestore.collection('orders').doc(orderId).set({
//   //         'orderId': orderId,
//   //         'userId': userId,
//   //         'username': _userName,
//   //         'email': _userEmail,
//   //         'paymentMethod': _selectedPaymentMethod,
//   //         'deliveryAddress': _address, // Use address from user_address
//   //         'phoneNumber': _phoneNumber,
//   //         'upiStatus': _upiStatus,
//   //         'totalPrice': widget.totalPrice,
//   //         'timestamp': FieldValue.serverTimestamp(),
//   //       });

//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('Order details saved successfully!'),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('User not logged in!'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print('Error saving order details: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Error saving order details.'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'track_order.dart'; // Ensure the correct path to TrackOrderPage
import 'plant_class_file.dart';
import  'plant_detail_page.dart';
class PaymentMethodsPage extends StatefulWidget {
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems; // Added cart items

  PaymentMethodsPage({required this.totalPrice, required this.cartItems});

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedPaymentMethod = '';
  String _phoneNumber = '';
  bool _isPhoneNumberVerified = false;
  String _upiStatus = 'Pending';
  bool _isPaymentSuccessful = false;

  
  String _city = '';
  String _address = '';
  String _pincode = '';
  String _userName = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchUserAddress(); 
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc['username'] ?? '';
            _userEmail = userDoc['email'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchUserAddress() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;
        DocumentSnapshot addressDoc = await _firestore.collection('user_addresses').doc(userId).get();

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
  Future<String?> _saveOrderDetails() async {
  try {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      String orderId = _firestore.collection('orders').doc().id;

      // Fetch item IDs from the 'carts' collection for the current user
      QuerySnapshot cartSnapshot = await _firestore.collection('carts').where('userId', isEqualTo: userId).get();
      
      // Extract item IDs from the cartSnapshot
      List<String> itemIds = cartSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['plantId'] as String; // Assuming 'id' is the field in your cart document
      }).toList();

      // Save order details
      await _firestore.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': userId,
        'username': _userName,
        'email': _userEmail,
        'paymentMethod': _selectedPaymentMethod,
        'deliveryAddress': _address,
        'phoneNumber': _phoneNumber,
        'upiStatus': _upiStatus,
        'totalPrice': widget.totalPrice,
        'itemIds': itemIds, // Store the fetched item IDs
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order details saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      return orderId;  // Return the orderId
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not logged in!'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  } catch (e) {
    print('Error saving order details: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error saving order details.'),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  }
}

  // Future<String?> _saveOrderDetails() async {
  //   try {
  //     User? user = _auth.currentUser;

  //     if (user != null) {
  //       String userId = user.uid;
  //       String orderId = _firestore.collection('orders').doc().id;

  //       await _firestore.collection('orders').doc(orderId).set({
  //         'orderId': orderId,
  //         'userId': userId,
  //         'username': _userName,
  //         'email': _userEmail,
  //         'paymentMethod': _selectedPaymentMethod,
  //         'deliveryAddress': _address, 
  //         'phoneNumber': _phoneNumber,
  //         'upiStatus': _upiStatus,
  //         'totalPrice': widget.totalPrice,
  //         'cartItems': widget.cartItems, 
  //         'timestamp': FieldValue.serverTimestamp(),
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Order details saved successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //       return orderId;  // Return the orderId
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('User not logged in!'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error saving order details: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error saving order details.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return null;
  //   }
  // }
//   Future<String?> _saveOrderDetails() async {
//   try {
//     User? user = _auth.currentUser;

//     if (user != null) {
//       String userId = user.uid;
//       String orderId = _firestore.collection('orders').doc().id;

//       // Convert cart items
//       List<Map<String, dynamic>> simpleCartItems = widget.cartItems.map((item) {
//         if (item is Plant) {
//           return item.toMap();  // Convert Plant to a map
//         } else if (item is Map<String, dynamic>) {
//           return item;  // If already a simple map, return as is
//         } else {
//           // Handle unexpected types
//           print('Unexpected cart item type: ${item.runtimeType}');
//           return {}; // Return an empty map or handle accordingly
//         }
//       }).toList();

//       await _firestore.collection('orders').doc(orderId).set({
//         'orderId': orderId,
//         'userId': userId,
//         'username': _userName,
//         'email': _userEmail,
//         'paymentMethod': _selectedPaymentMethod,
//         'deliveryAddress': _address,
//         'phoneNumber': _phoneNumber,
//         'upiStatus': _upiStatus,
//         'totalPrice': widget.totalPrice,
//         'cartItems': simpleCartItems,  // Use converted cart items
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Order details saved successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       return orderId;  // Return the orderId
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('User not logged in!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return null;
//     }
//   } catch (e) {
//     print('Error saving order details: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error saving order details.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     return null;
//   }
// }

  void _verifyPhoneNumber() {
    setState(() {
      _isPhoneNumberVerified = true; // Assume the OTP is always correct for demo purposes
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number verified successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyUPIPayment() {
    setState(() {
      _upiStatus = 'Done';
      _isPaymentSuccessful = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('UPI Payment successful!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showPaymentForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow[100]!, Colors.green[300]!, Colors.teal[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedPaymentMethod,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 20),
                if (_selectedPaymentMethod == 'Cash on Delivery') _buildCashOnDeliveryForm(),
                if (_selectedPaymentMethod == 'UPI Transaction') _buildUPITransactionForm(),
                SizedBox(height: 20),
                _buildProceedButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPaymentOptionTile(
            icon: Icons.money_off,
            title: 'Cash on Delivery',
            method: 'Cash on Delivery',
          ),
          Divider(),
          _buildPaymentOptionTile(
            icon: Icons.payment,
            title: 'UPI Transaction',
            method: 'UPI Transaction',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptionTile({
    required IconData icon,
    required String title,
    required String method,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: Icon(
        icon,
        color: _selectedPaymentMethod == method ? Colors.green[600] : Colors.teal[400],
      ),
      title: Text(title),
      tileColor: _selectedPaymentMethod == method ? Colors.green[100] : Colors.white,
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
        _showPaymentForm();
      },
    );
  }

  Widget _buildCashOnDeliveryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) {
            _phoneNumber = value;
          },
        ),
        SizedBox(height: 10),
        if (!_isPhoneNumberVerified)
          ElevatedButton(
            onPressed: _verifyPhoneNumber,
            child: Text('Verify Phone Number'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        if (_isPhoneNumberVerified)
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 40,
          ),
      ],
    );
  }

  Widget _buildUPITransactionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'UPI ID',
            hintText: 'your-upi-id@bank',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _verifyUPIPayment,
          child: Text('Verify Payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'UPI Payment Status: $_upiStatus',
          style: TextStyle(
            fontSize: 16,
            color: _upiStatus == 'Done' ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String? orderId = await _saveOrderDetails();
          if (orderId != null) {
            // Navigate to TrackOrderPage after saving order
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackOrderPage(
                  orderId: orderId,
                  paymentMethod: _selectedPaymentMethod,
                  deliveryAddress: _address,
                  phoneNumber: _phoneNumber,
                  totalPrice: widget.totalPrice,
                  upiStatus: _upiStatus,
                  name: _userName,
                  city: _city,
                  email: _userEmail,
                  pincode: _pincode,
                  cartItems: widget.cartItems, // Passing cart items
                ),
              ),
            );
          }
        },
        child: Text('Proceed'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildPaymentOptions(),
            SizedBox(height: 20),
            Text(
              'Total Price: ₹${widget.totalPrice}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 