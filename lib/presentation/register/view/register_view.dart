import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/di.dart';
import '../../resources/router/app_router.dart';
import '../viewmodel/register_viewmodel.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/constants/app_assets.dart';
import '../../resources/constants/app_strings.dart';
import '../../resources/constants/app_values.dart';
import '../../resources/styles/app_colors.dart';
import '../../resources/widgets/public_text_form_field.dart';
import '../../resources/widgets/public_button.dart';
import '../../resources/widgets/public_text.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = getIt<RegisterViewModel>();
  final ImagePicker _imagePicker = getIt<ImagePicker>();
  final GlobalKey _formKey = GlobalKey<FormState>();

  late final TextEditingController _userNameController;
  late final TextEditingController _mobileNumbercontroller;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void _bind() {
    _viewModel.start();

    _userNameController = TextEditingController();
    _mobileNumbercontroller = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _mobileNumbercontroller.addListener(() {
      _viewModel.setMobileNumber(_mobileNumbercontroller.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    // to listen when logged successfully in order to navigate
    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
        .listen((isLoggined) {
      // TODO: need more understand
      // To can navigate with passing context
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.main,
          (_) => false,
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _mobileNumbercontroller.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: AppColors.orange),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOuput,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.getScreenWidget(
              context: context,
              contentWidget: _getBody(),
              retryActionFunction: () => _viewModel.register(),
            );
          } else {
            return _getBody();
          }
        },
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPading.p24,
          right: AppPading.p24,
          bottom: AppPading.p24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.splashLogo,
                  height: 200.h,
                ),
                StreamBuilder<bool>(
                    stream: _viewModel.isUserNameValidOutput,
                    builder: (context, snapshot) {
                      return PublicTextFormField(
                        hint: AppStrings.username.tr(),
                        keyboardtype: TextInputType.text,
                        borderRadius: 12,
                        controller: _userNameController,
                        validator: (_) => snapshot.data ?? true
                            ? null
                            : AppStrings.userNameInvalid.tr(),
                      );
                    }),
                const SizedBox(height: AppSize.s20),
                Row(
                  children: [
                    Expanded(
                      child: CountryCodePicker(
                        initialSelection: '+20',
                        favorite: const ['+39', 'FR', '+966'],
                        showCountryOnly: true,
                        hideMainText: true,
                        showOnlyCountryWhenClosed: true,
                        onChanged: (countryCode) {
                          _viewModel
                              .setCountryMobileCode(countryCode.dialCode ?? "");
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: StreamBuilder<bool>(
                          stream: _viewModel.ismobileNumberValidOutput,
                          builder: (context, snapshot) {
                            return PublicTextFormField(
                              hint: AppStrings.mobileNumber.tr(),
                              controller: _mobileNumbercontroller,
                              keyboardtype: TextInputType.number,
                              borderRadius: 12,
                              validator: (_) => snapshot.data ?? true
                                  ? null
                                  : AppStrings.mobileNumberError.tr(),
                            );
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s20),
                StreamBuilder<bool>(
                    stream: _viewModel.isEmailValidOutput,
                    builder: (context, snapshot) {
                      return PublicTextFormField(
                        hint: AppStrings.emailAddress.tr(),
                        controller: _emailController,
                        keyboardtype: TextInputType.emailAddress,
                        borderRadius: 12,
                        validator: (_) => snapshot.data ?? true
                            ? null
                            : AppStrings.invalidEmail.tr(),
                      );
                    }),
                const SizedBox(height: AppSize.s20),
                StreamBuilder<bool>(
                    stream: _viewModel.isPasswordValidOutput,
                    builder: (context, snapshot) {
                      return PublicTextFormField(
                        hint: AppStrings.password.tr(),
                        controller: _passwordController,
                        keyboardtype: TextInputType.visiblePassword,
                        isPassword: true,
                        showSuffixIcon: true,
                        borderRadius: 12,
                        validator: (_) => snapshot.data ?? true
                            ? null
                            : AppStrings.passwordError.tr(),
                      );
                    }),
                const SizedBox(height: AppSize.s20),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightGrey, width: 1.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: MediaWidget(viewModel: _viewModel),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                StreamBuilder<bool>(
                  stream: _viewModel.areAllInputsValidOutput,
                  builder: (context, snapshot) {
                    return PublicButton(
                      title: AppStrings.register.tr(),
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.register();
                            }
                          : null,
                    );
                  },
                ),
                const SizedBox(height: AppSize.s10),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:  PublicText(
                    txt: AppStrings.alreadyHaveEmail.tr(),
                    color: AppColors.orange,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  title: const Text(AppStrings.camera).tr(),
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.orange,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.orange,
                  ),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.pop(context);
                  },),
              ListTile(
                  title: const Text(AppStrings.gallery).tr(),
                  leading: const Icon(
                    Icons.image_outlined,
                    color: AppColors.orange,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.orange,
                  ),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.pop(context);
                  },),
            ],
          ),
        );
      },
    );
  }

  void _imageFromCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _viewModel.setProfilePicture(File(image.path));
    }
  }

  void _imageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _viewModel.setProfilePicture(File(image.path));
    }
  }
}

class MediaWidget extends StatelessWidget {
  final RegisterViewModel viewModel;
  const MediaWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Flexible(
          flex: 2,
          child:  PublicText(
            txt: AppStrings.profilePicture.tr(),
            color: AppColors.grey,
            size: 16,
            fw: FontWeight.w500,
          ),
        ),
        Flexible(
          child: StreamBuilder<File>(
            stream: viewModel.profilePictureOutput,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          ),
        ),
        const Flexible(
            child: Icon(
          Icons.camera_alt_outlined,
          color: AppColors.orange,
        )),
      ],
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return CircleAvatar(
        maxRadius: 20,
        backgroundImage: FileImage(
          image,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
