import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.username,
    this.photo,
    this.balance = 0,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current username (display name).
  final String? username;

  /// Url for the current user's photo.
  final String? photo;

  /// Url for the current user's balance.
  final int balance;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Convert User object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'username': username,
      'photo': photo,
      'balance': balance,
    };
  }

  User copyWith({
    String? email,
    String? id,
    String? username,
    String? photo,
    int? balance,
  }) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
      username: username ?? this.username,
      photo: photo ?? this.photo,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [email, id, username, photo];
}
