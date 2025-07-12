import "dart:typed_data";

import "package:equatable/equatable.dart";

sealed class ProfilePicEvent extends Equatable {
  const ProfilePicEvent();

  @override
  List<Object?> get props => [];
}

class RequestPicFromSystemEvent extends ProfilePicEvent {}

class UploadProfilePicEvent extends ProfilePicEvent {
  final Uint8List bytes;
  final String fileName;
  final String mimeType;

  const UploadProfilePicEvent({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });

  @override
  List<Object?> get props => [bytes, fileName, mimeType];
}
