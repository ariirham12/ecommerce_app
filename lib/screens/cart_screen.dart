import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cart = [];

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> raw = prefs.getStringList('cart') ?? [];
    setState(() {
      cart = raw.map((item) => Product.fromJson(json.decode(item))).toList();
    });
  }

  double get total => cart.fold(0, (sum, item) => sum + item.price);

  void checkout() async {
    // Tampilkan dialog loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Memproses pembayaran...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulasi delay proses pembayaran
    await Future.delayed(Duration(seconds: 2));

    // Hapus isi keranjang
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('cart');
    setState(() => cart.clear());

    // Tutup dialog loading
    Navigator.pop(context);

    // Tampilkan dialog sukses dengan animasi Lottie
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/success.json', width: 150),
              SizedBox(height: 20),
              Text(
                'Pembayaran Berhasil!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Tunggu 3 detik, lalu tutup dialog sukses
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keranjang')),
      body: cart.isEmpty
          ? Center(child: Text('Keranjang kosong'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (_, i) {
                final p = cart[i];
                return ListTile(
                  leading: Image.network(p.image, width: 50),
                  title: Text(p.name),
                  subtitle: Text('Rp ${p.price}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: Rp $total',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: checkout,
                  icon: Icon(Icons.payment),
                  label: Text('Bayar Sekarang'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}