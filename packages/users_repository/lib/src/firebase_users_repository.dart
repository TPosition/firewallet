// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:users_repository/users_repository.dart';
import 'entities/entities.dart';

class FirebaseUsersRepository implements UsersRepository {
  final userCollection = fs.FirebaseFirestore.instance.collection('user');

  @override
  Future<void> addNewUser(User user) {
    return userCollection.doc(user.uid).set((user.toEntity().toDocument()));
  }

  @override
  Future<void> deleteUser(User user) async {
    return userCollection.doc(user.uid).delete();
  }

  @override
  Stream<List<User>> Users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateUser(User user) {
    return userCollection.doc(user.uid).update(user.toEntity().toDocument());
  }
}
