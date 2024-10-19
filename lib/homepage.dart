
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'plant_class_file.dart';
import 'plant_detail_page.dart';
import 'cart_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Plant> allPlants = [];
  List<Plant> filteredPlants = [];
    
  List<Map<String, dynamic>> cartItems = [];
  String selectedCategory = 'All';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('plants').get();
      for (var doc in snapshot.docs) {
        print(doc.data()); // Print each document's data
      }

      allPlants = snapshot.docs.map((doc) => Plant.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList();
      setState(() {
        filteredPlants = allPlants;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching plants: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterPlants(String query) {
    setState(() {
      filteredPlants = allPlants.where((plant) {
        final lowerQuery = query.toLowerCase();
        final matchesSearch = plant.name.toLowerCase().contains(lowerQuery) ||
            plant.scientificName.toLowerCase().contains(lowerQuery) ||
            plant.description.toLowerCase().contains(lowerQuery) ||
            plant.price.toString().contains(lowerQuery);

        final matchesCategory = selectedCategory == 'All' ||
            plant.category.toLowerCase() == selectedCategory.toLowerCase();

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filteredPlants = allPlants.where((plant) {
        return selectedCategory == 'All' || plant.category.toLowerCase() == selectedCategory.toLowerCase();
      }).toList();
    });
  }

  void _navigateToPlantDetail(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailPage(
          plant: plant,
          onAddToCart: (quantity) async {
            if (quantity > 0) {
              String userId = _auth.currentUser?.uid ?? '';
              if (userId.isNotEmpty) {
                DocumentReference cartRef = _firestore.collection('carts').doc(userId);
                DocumentSnapshot cartSnapshot = await cartRef.get();

                if (cartSnapshot.exists) {
                  List<dynamic> items = cartSnapshot.get('items') ?? [];
                  items.add({'plantId': plant.id, 'quantity': quantity ,'imageUrl': plant.imageUrl});

                  await cartRef.update({'items': items});
                } else {
                  await cartRef.set({'items': [{'plantId': plant.id, 'quantity': quantity,'imageUrl': plant.imageUrl}]});
                }

                setState(() {
                  cartItems.add({'plant': plant, 'quantity': quantity,'imageUrl': plant.imageUrl});
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${plant.name} added to cart!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  void _navigateToCartDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartDetailPage(),
      ),
    );
  }

  Future<void> _logOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100],
    appBar: AppBar(
      title: Text(
        'Green Square',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: _navigateToCartDetail,
        ),
        SizedBox(width: 12),
        TextButton(
          onPressed: _logOut,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          ),
          child: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search plants...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  _filterPlants(value); // Apply filter with new search query
                },
              ),
              SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('All'),
                    _buildCategoryButton('Indoor'),
                    _buildCategoryButton('Succulent'),
                    _buildCategoryButton('Outdoor'),
                    _buildCategoryButton('Flowering'),
                    // Add more categories as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : filteredPlants.isEmpty
            ? Center(child: Text('No plants found.'))
            : GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredPlants.length,
                itemBuilder: (context, index) {
                  final plant = filteredPlants[index];
                  return GestureDetector(
                    onTap: () => _navigateToPlantDetail(plant),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                              child: Image.asset(
                                'assets/images/${plant.imageUrl}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Icon(Icons.broken_image, size: 50));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              plant.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              plant.scientificName,
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              '\$${plant.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final quantity = await _showQuantityDialog();
                                if (quantity != null && quantity > 0) {
                                  String userId = _auth.currentUser?.uid ?? '';
                                  if (userId.isNotEmpty) {
                                    DocumentReference cartRef = _firestore.collection('carts').doc(userId);
                                    DocumentSnapshot cartSnapshot = await cartRef.get();

                                    if (cartSnapshot.exists) {
                                      List<dynamic> items = cartSnapshot.get('items') ?? [];
                                      items.add({'plantId': plant.id, 'quantity': quantity,'imageUrl': plant.imageUrl});

                                      await cartRef.update({'items': items});
                                    } else {
                                      await cartRef.set({'items': [{'plantId': plant.id, 'quantity': quantity,'imageUrl': plant.imageUrl}]});
                                    }

                                    setState(() {
                                      cartItems.add({'plant': plant, 'quantity': quantity,'imageUrl': plant.imageUrl});
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${plant.name} added to cart!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: Icon(Icons.shopping_cart),
                              label: Text('Add to Cart'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
  );
}

  Future<int?> _showQuantityDialog() {
    int quantity = 1;
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Quantity'),
            onChanged: (value) {
              quantity = int.tryParse(value) ?? 1;
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            ElevatedButton(
              child: Text('Add to Cart'),
              onPressed: () {
                Navigator.of(context).pop(quantity);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryButton(String category) {
    bool isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (_) => _filterByCategory(category),
        selectedColor: Colors.green[300],
        backgroundColor: Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

 