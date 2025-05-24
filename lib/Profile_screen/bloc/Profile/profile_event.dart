import 'dart:io';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final String userId;

  FetchProfileEvent(this.userId);
}

class UpdateProfileEvent extends ProfileEvent {
  final String userId;
  final String username;
  final String email;
  final String phone;
  final String? password; // إضافة كلمة السر
  final File? image; // إضافة الصورة

  UpdateProfileEvent(
    this.userId,
    this.username,
    this.email,
    this.phone, {
    this.password,
    this.image,
  });
}
