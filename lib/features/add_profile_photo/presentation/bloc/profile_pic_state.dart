import "dart:typed_data";

import "package:equatable/equatable.dart";

sealed class ProfilePicState extends Equatable {
  const ProfilePicState();

  @override
  List<Object?> get props => [];
}

class EmptyProfilePicState extends ProfilePicState {}

class FilledProfilePicState extends ProfilePicState {
  final Uint8List bytes;
  final String? fileName;
  final String? mimeType;

  const FilledProfilePicState({
    required this.bytes,
    this.fileName,
    this.mimeType,
  });

  @override
  List<Object?> get props => [bytes, fileName, mimeType];
}

class ProfilePicUploadingState extends FilledProfilePicState {
  const ProfilePicUploadingState({
    required super.bytes,
    super.fileName,
    super.mimeType,
  });
}

class ProfilePicUploadSuccessState extends FilledProfilePicState {
  final String newPicUrl;

  const ProfilePicUploadSuccessState({
    required this.newPicUrl,
    required super.bytes,
    super.fileName,
    super.mimeType,
  });

  @override
  List<Object?> get props => [newPicUrl, ...super.props];
}

class ProfilePicUploadFailedState extends FilledProfilePicState {
  const ProfilePicUploadFailedState({
    required super.bytes,
    super.fileName,
    super.mimeType,
  });
}
