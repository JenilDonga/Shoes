// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'SingleProductPage.dart';
import 'home_page.dart';

class SparksPage extends StatefulWidget {
  const SparksPage({super.key});

  @override
  _SparksPageState createState() => _SparksPageState();
}

class _SparksPageState extends State<SparksPage> {
  final List<Map<String, String>> _sparksProducts = [
    <String, String>{
      'image': 'assets/images/sparx/1.jpeg',
      'name': 'Sparks 1',
      'detail': 'Cool Runner',
      'price': '\$70'
    },

    {
      'image': 'assets/images/sparx/2.jpeg',
      'name': 'Sparks 2',
      'detail': 'City Walker',
      'price': '\$80'
    },

    {
      'image': 'assets/images/sparx/3.jpeg',
      'name': 'Sparks 3',
      'detail': 'Sporty Blaze',
      'price': '\$60'
    },

    {
      'image': 'assets/images/sparx/4.jpg',
      'name': 'Sparks 4',
      'detail': 'Trail Hunter',
      'price': '\$90'
    },

  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = _sparksProducts.where((
        product) {
      return product['name']!.toLowerCase().contains(
          _searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sparks'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Sparks shoes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Grid view for Sparks shoes
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                    onTap: () {
                  // Navigate to SingleProductPage when card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SingleProductPage(product: product),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            filteredProducts[index]['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filteredProducts[index]['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          filteredProducts[index]['detail']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filteredProducts[index]['price']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Container(
                      //     width:112,
                      //     height: 35,
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //         colors: [Colors.black, Colors.grey],
                      //         begin: Alignment.topLeft,
                      //         end: Alignment.bottomRight,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => HomePage()),
                      //         );
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.transparent,
                      //         shadowColor: Colors.transparent,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         minimumSize: Size(double.infinity, 36),
                      //       ),
                      //       child: Text(
                      //         'BUY',
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SparksPage(),
  ));
}
