import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class User {
  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;

  User({
    required this.uid,
    required this.balance,
    required this.displayName,
    required this.email,
    required this.mobile,
    required this.photoURL,
  });

  // User copyWith({bool? complete, String? note, String? task}) {
  //   return User(
  //     id: id,
  //     task: task ?? this.task,
  //     complete: complete ?? this.complete,
  //     note: note ?? this.note,
  //   );
  // }

  @override
  int get hashCode {
    return uid.hashCode ^
        balance.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        photoURL.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            uid == other.uid &&
            balance == other.balance &&
            displayName == other.displayName &&
            email == other.email &&
            mobile == other.mobile &&
            photoURL == other.photoURL;
  }

  @override
  String toString() {
    return 'User{uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL}';
  }

  UserEntity toEntity() {
    return UserEntity(
        uid: uid,
        balance: balance,
        displayName: displayName,
        email: email,
        mobile: mobile,
        photoURL: photoURL);
  }

  static User fromEntity(UserEntity entity) {
    return User(
        uid: entity.uid,
        balance: entity.balance,
        displayName: entity.displayName,
        email: entity.email,
        mobile: entity.mobile,
        photoURL: entity.photoURL);
  }
}
