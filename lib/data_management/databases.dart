import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference updates = FirebaseFirestore.instance.collection('updates');
CollectionReference cards = FirebaseFirestore.instance.collection('cards');
CollectionReference payouts = FirebaseFirestore.instance.collection('payouts');
CollectionReference investments =
    FirebaseFirestore.instance.collection('investments');
CollectionReference creditList =
    FirebaseFirestore.instance.collection('creditList');
CollectionReference userCredentials =
    FirebaseFirestore.instance.collection('userCredentials');
CollectionReference uiComponents =
    FirebaseFirestore.instance.collection('uiComponents');
CollectionReference transactionHistory =
    FirebaseFirestore.instance.collection('transactionHistory');
CollectionReference messages =
    FirebaseFirestore.instance.collection('messages');
