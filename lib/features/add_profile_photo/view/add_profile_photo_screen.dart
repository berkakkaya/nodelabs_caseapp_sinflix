import 'package:flutter/material.dart';
import 'package:nodelabs_caseapp_sinflix/core/consts/custom_icons.dart';
import 'package:nodelabs_caseapp_sinflix/core/widgets/custom_appbar.dart';
import 'package:nodelabs_caseapp_sinflix/features/add_profile_photo/view/widgets/add_profile_photo_widget.dart';

class AddProfilePhotoScreen extends StatefulWidget {
  const AddProfilePhotoScreen({super.key});

  @override
  State<AddProfilePhotoScreen> createState() => _AddProfilePhotoScreenState();
}

class _AddProfilePhotoScreenState extends State<AddProfilePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
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
              Row(
                children: [
                  Spacer(flex: 1),
                  Flexible(
                    flex: 7,
                    child: Text(
                      "Profil fotoğrafınız, toplulukta sizi temsil edecek.",
                      style: textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              SizedBox(height: 47.67),
              Row(
                children: [
                  Spacer(flex: 1),
                  Flexible(
                    flex: 7,
                    child: AddProfilePhotoWidget(
                      onTap: () {},
                      child: Icon(CustomIcons.plus, size: 26),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              Spacer(),
              FilledButton(onPressed: () {}, child: Text("Devam Et")),
            ],
          ),
        ),
      ),
    );
  }
}
