import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/data_management/databases.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: uiComponents.doc("view").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Text(
                'Loading',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ));
            }
            var view = snapshot.data;
            print('view here');
            print(view);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Portfolios')],
            );
          },
        ),
      ),
    );
  }
}
