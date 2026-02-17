// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String body;

  const Product({required this.id, required this.title, required this.body});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'title': title, 'body': body};
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  Product copyWith({int? id, String? title, String? body}) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [id, title, body];
}
