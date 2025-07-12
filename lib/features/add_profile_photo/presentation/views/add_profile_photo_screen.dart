import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart" as image_picker;
import "package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/custom_appbar.dart";
import "package:nodelabs_caseapp_sinflix/core/widgets/flexible_row_spacer.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/data/repositories/profile_photo_repository_impl.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/repositories/profile_photo_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/domain/usecases/pick_image_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/bloc/profile_pic_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/bloc/profile_pic_event.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/bloc/profile_pic_state.dart";
import "package:nodelabs_caseapp_sinflix/features/add_profile_photo/presentation/views/widgets/add_profile_photo_widget.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/repositories/user_repository.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/domain/usecases/upload_profile_photo_usecase.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/auth/auth_event.dart"
    show UserDataReloadReqEvent;

class AddProfilePhotoScreen extends StatefulWidget {
  const AddProfilePhotoScreen({super.key});

  @override
  State<AddProfilePhotoScreen> createState() => _AddProfilePhotoScreenState();
}

class _AddProfilePhotoScreenState extends State<AddProfilePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => _createProfilePicBloc(context),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 38, left: 26, right: 26, bottom: 26),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppbar(title: Text("Profil Detayı")),
                SizedBox(height: 35.64),
                Text(
                  "Fotoğraflarınızı yükleyin",
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.24),
                FlexibleRowSpacer(
                  child: Text(
                    "Profil fotoğrafınız, toplulukta sizi temsil edecek.",
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 47.67),
                FlexibleRowSpacer(
                  childFlex: 3,
                  child: BlocBuilder<ProfilePicBloc, ProfilePicState>(
                    builder: (context, state) {
                      final bloc = context.read<ProfilePicBloc>();

                      return AddProfilePhotoWidget(
                        onTap: state is! ProfilePicUploadingState
                            ? () => bloc.add(RequestPicFromSystemEvent())
                            : null,
                        child: state is FilledProfilePicState
                            ? Image.memory(state.bytes, fit: BoxFit.cover)
                            : Icon(CustomIcons.plus, size: 26),
                      );
                    },
                  ),
                ),
                Spacer(),
                BlocConsumer<ProfilePicBloc, ProfilePicState>(
                  listenWhen: (previous, current) =>
                      current is ProfilePicUploadFailedState ||
                      current is ProfilePicUploadSuccessState,
                  listener: _listenPicUploadStatusChanges,
                  builder: (context, state) {
                    final bloc = context.read<ProfilePicBloc>();

                    return FilledButton(
                      onPressed:
                          state is FilledProfilePicState &&
                              state is! ProfilePicUploadingState
                          ? () => bloc.add(
                              UploadProfilePicEvent(
                                bytes: state.bytes,
                                fileName: state.fileName!,
                                mimeType: state.mimeType!,
                              ),
                            )
                          : null,
                      child: Text(
                        state is ProfilePicUploadingState
                            ? "Fotoğraf yükleniyor..."
                            : "Devam Et",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listenPicUploadStatusChanges(
    BuildContext context,
    ProfilePicState state,
  ) {
    if (state is ProfilePicUploadFailedState) {
      // Show error message on upload failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fotoğraf yüklenemedi. Lütfen tekrar deneyin.")),
      );

      return;
    }

    if (state is ProfilePicUploadSuccessState) {
      // Show success message and navigate back on successful upload
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fotoğraf başarıyla yüklendi.")));

      // Request a user data reload in AuthBloc
      final authBloc = context.read<AuthBloc>();
      authBloc.add(UserDataReloadReqEvent());

      // Navigate to the home screen or any other screen as needed
      Navigator.of(context).pop();
    }
  }

  ProfilePicBloc _createProfilePicBloc(BuildContext context) {
    // NOTE: This is a workaround to get the UserRepository from the AuthBloc.
    // We should probably refactor the code in the future to avoid this.
    final authBloc = context.read<AuthBloc>();
    final UserRepository userRepository =
        authBloc.uploadProfilePhotoUseCase.repository;

    final ProfilePhotoRepository profilePicRepo = ProfilePhotoRepositoryImpl(
      userRepository: userRepository,
      imagePicker: image_picker.ImagePicker(),
    );

    return ProfilePicBloc(
      pickImageUseCase: PickImageUseCase(profilePicRepo),
      uploadProfilePhotoUseCase: UploadProfilePhotoUseCase(userRepository),
    );
  }
}
