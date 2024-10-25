import 'package:flutter/material.dart';
import 'SingleProductPage.dart'; // Import the SingleProductPage

class AdidasPage extends StatefulWidget {
  const AdidasPage({super.key});

  @override
  _AdidasPageState createState() => _AdidasPageState();
}

class _AdidasPageState extends State<AdidasPage> {
  final List<Map<String, String>> _adidasProducts = [
    {
      'image': 'assets/images/adidas/1.jpeg',
      'name': 'Adidas 1',
      'detail': 'UltraBoost',
      'price': '\$180'
    },
    {
      'image': 'assets/images/adidas/2.jpeg',
      'name': 'Adidas 2',
      'detail': 'NMD R1',
      'price': '\$140'
    },
    {
      'image': 'assets/images/adidas/3.jpg',
      'name': 'Adidas 3',
      'detail': 'Superstar',
      'price': '\$100'
    },
    {
      'image': 'assets/images/adidas/4.jpg',
      'name': 'Adidas 4',
      'detail': 'Stan Smith',
      'price': '\$120'
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = _adidasProducts.where((product) {
      return product['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Adidas'),
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
                hintText: 'Search Adidas shoes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Grid view for Adidas shoes
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
                        builder: (context) => SingleProductPage(product: product),
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
                              product['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            product['name']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            product['detail']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            product['price']!,
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
                        //     width: 112,
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
                        //           MaterialPageRoute(
                        //             builder: (context) => SingleProductPage(product: product),
                        //           ),
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
                        // ),
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
