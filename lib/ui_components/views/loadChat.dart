import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/styleSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoadChat extends StatefulWidget {
  @override
  _LoadChatState createState() => _LoadChatState();
}

class _LoadChatState extends State<LoadChat> {
  String id;
  int count = 1;
  int a;
  bool loading;
  dynamic now;
  ScrollController scrollController = new ScrollController();
  final nameHolder = TextEditingController();
  var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final Map<String, dynamic> formData = {
    'count': null,
    'type': 'ask',
    'userID': null,
    'time': null,
    'date': DateFormat.yMMMMd('en_US').format(new DateTime.now()).toString(),
    'text': ''
  };
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getId();
  }

  Future<void> sendMessage() {
    // Call the user's CollectionReference to add a new user
    return messages.add(formData).then((value) {
      //setState(() {});
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Done Processing Data')));
    }).catchError((error) {
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Something went wrong')));
    });
  }

  Widget _buildMessage(message, bool isMe) {
    final Column msg = Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
            width: MediaQuery.of(context).size.width * 0.55,
            //color: Colors.red,
            margin: isMe
                ? EdgeInsets.only(top: 7.0, left: 80.0)
                : EdgeInsets.only(
                    top: 8.0,
                  ),
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              '${message['time']} ${message['date']}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            margin: isMe
                ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
                : EdgeInsets.only(top: 8.0, bottom: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            decoration: isMe
                ? BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)))
                : BoxDecoration(
                    color: Color(0xFFe4f1fe),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
            child: isMe
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(message['text'],
                          style: TextStyle(
                              color: white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(message['text'],
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
          )
        ]);
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        // IconButton(
        //   icon: message.isLiked
        //       ? Icon(Icons.favorite)
        //       : Icon(Icons.favorite_border),
        //   iconSize: 30.0,
        //   color: message.isLiked ? Colors.red : Colors.blueGrey,
        //   onPressed: () {},
        // ),
      ],
    );
  }

  _buildMessageComposer(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25.0,
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          Expanded(
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: nameHolder,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ask us anything...',
                    hintStyle: inputTextStyle()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  if (value != '') {
                    now = new DateTime.now();
                    formData['text'] = value;
                    formData['count'] = count;
                    formData['time'] = '${now.hour}:${now.minute}';
                  }
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              formKey.currentState.save();
              print(formData);
              // Scaffold.of(context)
              //     .showSnackBar(SnackBar(content: Text('Processing Data')));
              nameHolder.clear();
              sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Future<void> getId() async {
    loading = true;
    print('is here');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('userID');
    var docID = prefs.getString('userDocId');
    formData['userID'] = id;
    print('hits here');
    return userCredentials
        .doc(docID)
        .update({'hasMessage': 'no'}).then((value) {
      loading = false;
      setState(() {});
    }).catchError((error) {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // scrollController.animateTo(
    //   0.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
    return !loading
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              child: Column(
                children: <Widget>[
                  //HeaderBack(),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: messages
                            .where('userID', isEqualTo: id)
                            .orderBy('count', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            a = 0;
                            return Center(child: CircularProgressIndicator());
                          }

                          return new ListView(
                            controller: scrollController,
                            reverse: true,
                            shrinkWrap: true,
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              print('enters here');
                              print(id);
                              a++;
                              print('count');
                              print(a);
                              count = a;
                              print('docs here');
                              print(DateFormat.yMMMMd('en_US')
                                  .format(new DateTime.now()));

                              print(document.data());
                              final message = document.data();
                              final bool isMe =
                                  'ask' == document.data()['type'];
                              return _buildMessage(message, isMe);
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  _buildMessageComposer(context),
                ],
              ),
            ),
          )
        : Center(
            child: Text(
            'Loading...',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
            //),
            );
  }
}
