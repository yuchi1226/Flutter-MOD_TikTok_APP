import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('user_details').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                        child: ListTile(
                      title: Text('${snapshot.data!.docs[index]["Name"]}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${snapshot.data!.docs[index]["Age"]}'),
                          Text('${snapshot.data!.docs[index]["Email"]}')
                        ],
                      ),
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length);
            }
          }),
    );
  }
}
