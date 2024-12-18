import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  final bool selectedAddress;

  AddressModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.street,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.country,
      this.dateTime,
      this.selectedAddress = true});

  String get formattedPhoneNo => FFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': '',
      'Street': street,
      'City': '',
      'State': '',
      'PostalCode': '',
      'Country': '',
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'],
      phoneNumber: data['PhoneNumber'],
      street: data['Street'],
      city: data['City'],
      state: data['State'],
      postalCode: data['PostalCode'],
      country: data['Country'],
      dateTime: DateTime.now(),
    );
  }

  /// Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
        id: snapshot.id,
        name: data['Name'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        street: data['Street'] ?? '',
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        postalCode: data['PostalCode'] ?? '',
        country: data['Country'] ?? '',
        selectedAddress: data['SelectedAddress'] as bool,
        dateTime: (data['DateTime'] as Timestamp).toDate());
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
