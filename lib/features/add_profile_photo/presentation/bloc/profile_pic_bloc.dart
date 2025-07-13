import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/entities/image_source.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/usecases/pick_image_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/bloc/profile_pic_event.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/bloc/profile_pic_state.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/upload_profile_photo_usecase.dart";

/// [ProfilePicBloc] is a BLoC (Business Logic Component) responsible for
/// managing the state and events related to selecting and uploading a user's
/// profile picture.
///
/// It interacts with a [UserRepository] to handle the upload process and emits
/// various states to reflect the current status of the profile picture
/// selection and upload workflow.
///
/// This BLoC ensures a clear separation of concerns and provides a reactive way
/// to manage profile picture selection and upload in the application.
class ProfilePicBloc extends Bloc<ProfilePicEvent, ProfilePicState> {
  final PickImageUseCase pickImageUseCase;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;

  ProfilePicBloc({
    required this.pickImageUseCase,
    required this.uploadProfilePhotoUseCase,
  }) : super(EmptyProfilePicState()) {
    on<RequestPicFromSystemEvent>(_onSelectProfilePic);
    on<UploadProfilePicEvent>(_uploadProfilePic);
  }

  void _onSelectProfilePic(
    RequestPicFromSystemEvent event,
    Emitter<ProfilePicState> emit,
  ) async {
    final newImg = await pickImageUseCase.execute(source: ImageSource.gallery);

    if (newImg == null) {
      return;
    }

    emit(
      FilledProfilePicState(
        bytes: newImg.bytes,
        fileName: newImg.fileName,
        mimeType: newImg.mimeType,
      ),
    );
  }

  void _uploadProfilePic(
    UploadProfilePicEvent event,
    Emitter<ProfilePicState> emit,
  ) async {
    emit(
      ProfilePicUploadingState(
        bytes: event.bytes,
        fileName: event.fileName,
        mimeType: event.mimeType,
      ),
    );

    final newPicUrl = await uploadProfilePhotoUseCase.execute(
      event.bytes,
      filename: event.fileName,
    );

    if (newPicUrl != null) {
      emit(
        ProfilePicUploadSuccessState(
          newPicUrl: newPicUrl,
          bytes: event.bytes,
          fileName: event.fileName,
          mimeType: event.mimeType,
        ),
      );
    } else {
      emit(
        ProfilePicUploadFailedState(
          bytes: event.bytes,
          fileName: event.fileName,
          mimeType: event.mimeType,
        ),
      );
    }
  }
}
