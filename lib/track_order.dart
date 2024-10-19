 import 'package:flutter/material.dart';

// class TrackOrderPage extends StatelessWidget {
//   final String paymentMethod;
//   final String deliveryAddress;
//   final String phoneNumber;
//   final double totalPrice;
//   final String upiStatus;
//   final String name;
//   final String city;
//   final String email;
//   final String pincode;
//   final String orderId;

//   TrackOrderPage({
//     required this.paymentMethod,
//     required this.deliveryAddress,
//     required this.phoneNumber,
//     required this.totalPrice,
//     required this.upiStatus,
//     required this.name,
//     required this.city,
//     required this.email,
//     required this.pincode,
//     required this.orderId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Bill'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Store Name
//             Text(
//               'GREEN SQUARE',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
            
//             // Customer Info
//             Text('Customer Name: $name'),
//             Text('Email: $email'),
//             Text('Address: $deliveryAddress, $city - $pincode'),
//             Text('Phone Number: $phoneNumber'),
//             SizedBox(height: 20),
            
//             // Order Info
//             Text('Order ID: $orderId'),
//             Text('Payment Method: $paymentMethod'),
//             Text('UPI Status: $upiStatus'),
//             SizedBox(height: 20),
            
//             // Order Summary
//             Text(
//               'Order Summary',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Divider(),
//             // Assuming you have order items, you can dynamically list them here.
//             // Example of a single item (you would replace this with your actual data).
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Plant XYZ'),
//                 Text('2'),
//                 Text('₹500'),
//               ],
//             ),
//             Divider(),
//             SizedBox(height: 10),
            
//             // Total Price
//             Text(
//               'Total: ₹$totalPrice',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class TrackOrderPage extends StatelessWidget {
  final String paymentMethod;
  final String deliveryAddress;
  final String phoneNumber;
  final double totalPrice;
  final String upiStatus;
  final String name;
  final String city;
  final String email;
  final String pincode;
  final String orderId;
  final List<Map<String, dynamic>> cartItems;

  TrackOrderPage({
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.phoneNumber,
    required this.totalPrice,
    required this.upiStatus,
    required this.name,
    required this.city,
    required this.email,
    required this.pincode,
    required this.orderId,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Bill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Name
            Text(
              'GREEN SQUARE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Customer Info
            Text('Customer Name: $name'),
            Text('Email: $email'),
            Text('Address: $deliveryAddress, $city - $pincode'),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 20),
            
            // Order Info
            Text('Order ID: $orderId'),
            Text('Payment Method: $paymentMethod'),
            Text('UPI Status: $upiStatus'),
            SizedBox(height: 20),
            
            // Order Summary
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            
            // List of cart items
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['name']),       // Item name
                      Text(item['quantity'].toString()),  // Item quantity
                      Text('₹${item['price']}'),  // Item price
                    ],
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            
            // Total Price
            Text(
              'Total: ₹$totalPrice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
