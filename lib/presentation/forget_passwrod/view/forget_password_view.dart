import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/widgets/public_text.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/constants/app_assets.dart';
import '../../resources/constants/app_strings.dart';
import '../../resources/constants/app_values.dart';
import '../../resources/styles/app_colors.dart';
import '../../resources/widgets/public_text_form_field.dart';
import '../../resources/widgets/public_button.dart';
import '../viewmodel/forget_password_viewmodel.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final ForgetPasswordViewModel _viewModel = getIt<ForgetPasswordViewModel>();

  late final TextEditingController _emailController;

  void bind() {
    _viewModel.start();
    _emailController = TextEditingController();
    _emailController.addListener(
      () {
        _viewModel.setEmail(_emailController.text);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOuput,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.getScreenWidget(
              context: context,
              contentWidget: _getBody(),
              retryActionFunction: (){
                // no need 
              },
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
        padding: const EdgeInsets.all(AppPading.p24),
        child: Center(
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
                      stream: _viewModel.isEmailValidOutput,
                      builder: (context, snapshot) {
                        return PublicTextFormField(
                          hint: AppStrings.emailAddress.tr(),
                          keyboardtype: TextInputType.emailAddress,
                          borderRadius: 12,
                          controller: _emailController,
                          validator: (_) => snapshot.data ?? true
                              ? null
                              : AppStrings.invalidEmail.tr(),
                        );
                      }),
                  const SizedBox(height: AppSize.s20),
                  StreamBuilder<bool>(
                    stream: _viewModel.isEmailValidOutput,
                    builder: (context, snapshot) {
                      log(snapshot.data.toString());
                      return PublicButton(
                        title: AppStrings.forgetPassword.tr(),
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.forgetPassword();
                              }
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    children: [
                       PublicText(
                        txt: AppStrings.didNotReceiveEmail.tr(),
                        color: AppColors.black,
                        size: 14,
                      ),
                      InkWell(
                        onTap: () {},
                        child:  PublicText(
                          txt: AppStrings.resend.tr(),
                          color: AppColors.orange,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
