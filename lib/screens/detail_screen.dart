import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: product.id,
            child: Image.network(
              product.image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Rp ${product.price}',
              style: TextStyle(fontSize: 20, color: Colors.deepOrange),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Deskripsi produk ini bisa disesuaikan. Kamu dapat menambahkan fitur lain seperti rating, ulasan, dan spesifikasi.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Di sini bisa ditambahkan ke cart kalau mau
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produk ditambahkan ke keranjang!')),
                );
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Tambahkan ke Keranjang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
