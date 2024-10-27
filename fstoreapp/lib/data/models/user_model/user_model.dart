import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fstoreapp/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String password;
  String profilePicture;
  String phoneNumber;

  UserModel(
      {required this.id,
      required this.email,
      this.firstName = '',
      this.lastName = '',
      this.userName = '',
      this.password = '',
      this.profilePicture = '',
      this.phoneNumber = ''});

  String get fullName => '$firstName $lastName';
  String get formattedPhoneNumber => FFormatter.formatPhoneNumber(phoneNumber);
  // Static method to split fullName into First and Last name
  static List<String> nameParts(String fullName) => fullName.split(' ');

  // Static method to generate username from fullName
  static String generateUserName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';
    String camelCaseUsername = '$firstName$lastName';

    String userNameWithPrefix = '#cwf_$camelCaseUsername';
    return userNameWithPrefix;
  }

  // Static function to create an empty UserModel
  static UserModel empty() => UserModel(email: '',id: '');

  /// Convert Model to json format for storing in the database
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'FullName': fullName,
      'Email': email,
      'ProfilePicture': profilePicture,
      'PhoneNumber': phoneNumber,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          email: data.containsKey('Email') ? data['Email'] ?? '' : '',
          firstName:
              data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
          lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
          userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
          profilePicture: data.containsKey('ProfilePicture')
              ? data['ProfilePicture'] ?? ''
              : '',
          phoneNumber:
              data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '');
    } else {
      return UserModel.empty();
    }
  }
}
