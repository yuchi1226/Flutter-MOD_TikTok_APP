import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/add_data.dart';
import 'package:flutter_mod_tiktok_app/fetch_data.dart';

class ConnectionFirebase extends StatefulWidget {
  const ConnectionFirebase({super.key});

  @override
  State<ConnectionFirebase> createState() => _ConnectionFirebaseState();
}

class _ConnectionFirebaseState extends State<ConnectionFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Firebase Connection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.indigo,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddData()));
              },
              child: const Text(
                'Add data page',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FetchData()));
              },
              child: const Text(
                'Fetch Data Page',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
