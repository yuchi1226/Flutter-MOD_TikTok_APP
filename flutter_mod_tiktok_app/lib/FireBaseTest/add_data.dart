import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Data'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
              child: TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Name',
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromRGBO(147, 18, 18, 1.0),
                  ),
                  hintText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
              child: TextFormField(
                controller: agecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Age',
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromRGBO(147, 18, 18, 1.0),
                  ),
                  hintText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Email',
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromRGBO(147, 18, 18, 1.0),
                  ),
                  hintText: '',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {
                Map<String, dynamic> userDetails = {
                  'Name': namecontroller.text,
                  'Age': agecontroller.text,
                  'Email': emailcontroller.text,
                };
                CollectionReference collectionreference =
                    FirebaseFirestore.instance.collection('user_details');
                collectionreference.add(userDetails);
                print('clicked');
              },
              child: const Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
