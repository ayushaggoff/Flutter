import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfilePageEvent extends Equatable {}

class UpdateButtonPressedEvent extends ProfilePageEvent {
  String displayName, email, avartarUrl, gender, dob, phone;
  File image;
  UpdateButtonPressedEvent(
      {this.displayName,
      this.email,
      this.gender,
      this.dob,
      this.phone,
      this.image});
  @override
  List<Object> get props => throw UnimplementedError();
}

class InitEvent extends ProfilePageEvent {
  String displayName, email, avartarUrl, gender, dob, phone;
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileGallerySelected extends ProfilePageEvent {
  File image;
  String email;
  ProfileGallerySelected(this.image, this.email);
  @override
  List<Object> get props => throw UnimplementedError();
}
