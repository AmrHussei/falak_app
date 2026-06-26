import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AddRealStateParams extends Equatable {
  final String phoneNumber;
  final String name;
  final String city;
  final String area;
  final String neighborhood;
  final bool certified;
  final String description;
  final String deedNumber;
  final String capacity;
  final File propertyEvaluation;
  final File propertyDeed;

  const AddRealStateParams({
    required this.phoneNumber,
    required this.name,
    required this.city,
    required this.area,
    required this.neighborhood,
    required this.certified,
    required this.description,
    required this.deedNumber,
    required this.capacity,
    required this.propertyEvaluation,
    required this.propertyDeed,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        city,
        area,
        neighborhood,
        certified,
        description,
        deedNumber,
        capacity,
        propertyEvaluation,
        propertyDeed,
      ];

  String get sanitizedPhoneNumber {
    if (phoneNumber.startsWith('+966')) {
      return phoneNumber.replaceFirst('+966', '');
    }
    if (phoneNumber.startsWith('0')) {
      return phoneNumber.replaceFirst('0', '');
    }
    return phoneNumber;
  }

  Future<MultipartFile> _createMultipartFile(File file) async {
    if (!await file.exists()) {
      return Future.error('File not found');
    }
    final String mimeType =
        lookupMimeType(file.path) ?? 'application/octet-stream';
    final List<String> mimeParts = mimeType.split('/');

    if (mimeParts.length != 2) {
      throw UnsupportedError('Invalid MIME type: $mimeType');
    }

    return MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
      contentType: MediaType(mimeParts[0], mimeParts[1]),
    );
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'phoneNumber[number]': sanitizedPhoneNumber,
      'phoneNumber[key]': '+966',
      'name': name,
      'city': city,
      'area': area,
      'neighborhood': neighborhood,
      'certified': certified,
      'description': description,
      'deedNumber': deedNumber,
      'capacity': capacity,
      'propertyEvaluation': await _createMultipartFile(propertyEvaluation),
      'propertyDeed': await _createMultipartFile(propertyDeed),
    });
  }
}
