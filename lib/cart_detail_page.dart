
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'payment_methods.dart'; // Ensure this is the correct path to the PaymentMethodsPage
import 'plant_class_file.dart'; // Ensure this is the correct path to the Plant class file

class CartDetailPage extends StatefulWidget {
  @override
  _CartDetailPageState createState() => _CartDetailPageState();
}

class _CartDetailPageState extends State<CartDetailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> cartItems = []; 
  String _selectedPaymentMethod = 'Cash on Delivery'; 
  double _totalPrice = 0.0; 

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      if (userId.isNotEmpty) {
        DocumentReference cartRef = _firestore.collection('carts').doc(userId);
        DocumentSnapshot cartSnapshot = await cartRef.get();

        if (cartSnapshot.exists) {
          List<dynamic> items = cartSnapshot.get('items') ?? [];
          List<Map<String, dynamic>> fetchedItems = [];

          for (var item in items) {
            String plantId = item['plantId'];
            int quantity = item['quantity'];

            DocumentSnapshot plantSnapshot = await _firestore.collection('plants').doc(plantId).get();
            if (plantSnapshot.exists) {
              Plant plant = Plant.fromDocument(plantSnapshot.data() as Map<String, dynamic>, plantId);

              String imageUrl = await _getPlantImageUrl(plantId);
              plant = plant.copyWith(imageUrl: imageUrl);

              fetchedItems.add({'plant': plant, 'quantity': quantity});
            }
          }

          setState(() {
            cartItems = fetchedItems;
            _totalPrice = _calculateTotal();
          });
        }
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  double _calculateTotal() {
    return cartItems.fold(0.0, (total, item) {
      final plant = item['plant'] as Plant;
      final quantity = item['quantity'] as int;
      return total + (plant.price * quantity);
    });
  }

  Future<void> _updateCartItem(int index, int newQuantity) async {
    final plantId = cartItems[index]['plant'].id;
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      DocumentReference cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();
      if (cartSnapshot.exists) {
        List<dynamic> items = cartSnapshot.get('items');
        items[index]['quantity'] = newQuantity;

        await cartRef.update({'items': items});
        setState(() {
          cartItems[index]['quantity'] = newQuantity;
          _totalPrice = _calculateTotal();
        });
      }
    }
  }

  Future<void> _deleteCartItem(int index) async {
    final plantId = cartItems[index]['plant'].id;
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      DocumentReference cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();
      if (cartSnapshot.exists) {
        List<dynamic> items = cartSnapshot.get('items');
        items.removeAt(index);

        await cartRef.update({'items': items});
        setState(() {
          cartItems.removeAt(index);
          _totalPrice = _calculateTotal();
        });
      }
    }
  }

  Future<void> _showUpdateQuantityDialog(int index) async {
    final currentQuantity = cartItems[index]['quantity'] as int;
    int newQuantity = currentQuantity;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Quantity'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Quantity'),
            onChanged: (value) {
              newQuantity = int.tryParse(value) ?? currentQuantity;
            },
            controller: TextEditingController()..text = currentQuantity.toString(),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                _updateCartItem(index, newQuantity);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<void> _showAddressDialog() async {
  String address = '';
  String city = '';
  String pincode = '';

  await _fetchAddressDetails().then((details) {
    address = details['address'] ?? '';
    city = details['city'] ?? '';
    pincode = details['pincode'] ?? '';
  });

  final addressController = TextEditingController(text: address);
  final cityController = TextEditingController(text: city);
  final pincodeController = TextEditingController(text: pincode);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Delivery Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                address = value;
              },
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
              onChanged: (value) {
                city = value;
              },
            ),
            TextField(
              controller: pincodeController,
              decoration: InputDecoration(labelText: 'Pincode'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                pincode = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () async {
              if (address.isNotEmpty && city.isNotEmpty && pincode.isNotEmpty) {
                await _saveAddressDetails(address, city, pincode);
                Navigator.of(context).pop(); // Close the dialog
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill all fields.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

Future<Map<String, String>> _fetchAddressDetails() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final addressDoc = await FirebaseFirestore.instance
        .collection('user_addresses')
        .doc(user.uid)
        .get();

    if (addressDoc.exists) {
      return {
        'address': addressDoc.get('address') ?? '',
        'city': addressDoc.get('city') ?? '',
        'pincode': addressDoc.get('pincode') ?? '',
      };
    }
  }
  return {
    'address': '',
    'city': '',
    'pincode': '',
  };
}

  Future<void> _saveAddressDetails(String address, String city, String pincode) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('user_addresses').doc(userId).set({
          'address': address,
          'city': city,
          'pincode': pincode,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Address details saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error saving address details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving address details.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _getPlantImageUrl(String plantId) async {
    
    return '$plantId.png'; 
  }

  // void _handlePurchase() async {
  //   if (cartItems.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Your cart is empty!'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } else {
  //     await _showAddressDialog(); // Show the address dialog

  //     // Proceed to PaymentMethodsPage after saving address
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PaymentMethodsPage(
  //           totalPrice: _totalPrice, // Pass total price only
  //         ),
  //       ),
  //     ).then((selectedMethod) {
  //       if (selectedMethod != null) {
  //         setState(() {
  //           _selectedPaymentMethod = selectedMethod;
  //         });
  //       }
  //     });
  //   }
  // }
void _handlePurchase() async {
  if (cartItems.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your cart is empty!'),
        backgroundColor: Colors.red,
      ),
    );
  } else {
    await _showAddressDialog(); 

    await _createOrder();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsPage(
          totalPrice: _totalPrice, 
          cartItems: cartItems, 
        ),
      ),
    ).then((selectedMethod) {
      if (selectedMethod != null) {
        setState(() {
          _selectedPaymentMethod = selectedMethod;
        });
      }
    });
  }
}
// Future<void> _createOrder() async {
//   final user = _auth.currentUser;

//   if (user != null) {
//     String userId = user.uid;
    
//     // Prepare the order items with plant details and quantities
//     List<Map<String, dynamic>> orderItems = cartItems.map((item) {
//       final plant = item['plant'] as Plant;
//       final quantity = item['quantity'] as int;
//       return {
//         'plantId': plant.id,
//         'name': plant.name,
//         'price': plant.price,
//         'quantity': quantity,
//         'totalPrice': plant.price * quantity,
//       };
//     }).toList();

//     // Fetch address details
//     Map<String, String> addressDetails = await _fetchAddressDetails();
    
//     // Create the order document in Firestore
//     await _firestore.collection('orders').add({
//       'userId': userId,
//       'items': orderItems,
//       'totalPrice': _totalPrice,
//       'address': addressDetails['address'],
//       'city': addressDetails['city'],
//       'pincode': addressDetails['pincode'],
//       'status': 'pending', // You can add an initial status like 'pending'
//       'paymentMethod': _selectedPaymentMethod,
//       'orderDate': Timestamp.now(),
//     });

//     // Clear the cart after saving the order
//     await _clearCart();
    
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Order placed successfully!'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
Future<void> _createOrder() async {
  final user = _auth.currentUser;

  if (user != null) {
    String userId = user.uid;

    List<Map<String, dynamic>> orderItems = cartItems.map((item) {
      final plant = item['plant'] as Plant;
      final quantity = item['quantity'] as int;
      return {
        'plantId': plant.id,
        'name': plant.name,
        'price': plant.price,
        'quantity': quantity,
        'totalPrice': plant.price * quantity,
      };
    }).toList();

    Map<String, String> addressDetails = await _fetchAddressDetails();

    await _firestore.collection('orders').add({
      'userId': userId,
      'items': orderItems,
      'totalPrice': _totalPrice,
      'address': addressDetails['address'],
      'city': addressDetails['city'],
      'pincode': addressDetails['pincode'],
      'status': 'pending',
      'paymentMethod': _selectedPaymentMethod,
      'orderDate': Timestamp.now(),
    });

   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Future<void> _clearCart() async {
//   final userId = _auth.currentUser?.uid;

//   if (userId != null) {
//     await _firestore.collection('carts').doc(userId).set({
//       'items': [],
//     });

//     setState(() {
//       cartItems.clear();
//       _totalPrice = 0.0;
//     });
//   }
// }

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
            title: Text('Cart Details'),
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow for a cleaner look
            centerTitle: true,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.grey[400],
                    size: 100.0, // Adjust size as needed
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800], // Match text color
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final plant = item['plant'] as Plant;
                final quantity = item['quantity'] as int;

                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/${plant.imageUrl}'),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(
                      plant.name,
                      style: TextStyle(color: Colors.green[700]), // Match text color
                    ),
                    subtitle: Text(
                      '${plant.scientificName}\nQuantity: $quantity\nPrice: \$${(plant.price * quantity).toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.green[600]), // Match subtitle color
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green[700]), // Match icon color
                          onPressed: () => _showUpdateQuantityDialog(index),
                          splashColor: Colors.green[200],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            _deleteCartItem(index);
                          },
                          splashColor: Colors.red[200],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal[100], // Match bottom bar color
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${_totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              ElevatedButton(
                onPressed: _handlePurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400], // Match button color
                ),
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
