import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/general_components/favourite_component.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userEmailProvider = Provider<String?>((ref) {
  final user = ref.watch(firebaseUserProvider).asData?.value;
  return user?.email?.toLowerCase(); // Normalize casing for consistency
});



// The family modifier creates a new provider instance for each unique user ID.
