import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/constants/app_strings.dart';
import '../../resources/router/app_router.dart';
import '../../resources/widgets/public_button.dart';
import '../../resources/widgets/public_text.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../resources/constants/app_assets.dart';
import '../../resources/constants/app_values.dart';
import '../../resources/styles/app_colors.dart';
import '../../resources/widgets/public_text_form_field.dart';
import '../../../app/di.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _viewModel = getIt<LoginViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// the mehtod that is responsible for relating view model with view
  void _bind() {
    _viewModel.start();

    // - void addListener(void Function() listener)
    // - addListener methods means when any change happens in _userNameController, it executes function "listener"
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    // to listen when logged successfully in order to navigate
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggined) {
      // TODO: need more understand
      // To can navigate with passing context
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.main,
          (route) => false,
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
    _userNameController.dispose();
    _passwordController.dispose();
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
              retryActionFunction: () => _viewModel.login(),
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
                      stream: _viewModel.isUserNameValidOutput,
                      builder: (context, snapshot) {
                        return PublicTextFormField(
                          hint: AppStrings.userName,
                          keyboardtype: TextInputType.emailAddress,
                          borderRadius: 12,
                          controller: _userNameController,
                          validator: (_) => snapshot.data ?? true
                              ? null
                              : AppStrings.userNameError,
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  StreamBuilder<bool>(
                      stream: _viewModel.isPasswordValidOutput,
                      builder: (context, snapshot) {
                        return PublicTextFormField(
                          hint: AppStrings.password,
                          controller: _passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          isPassword: true,
                          showSuffixIcon: true,
                          borderRadius: 12,
                          validator: (_) => snapshot.data ?? true
                              ? null
                              : AppStrings.passwordError,
                        );
                      }),
                  const SizedBox(height: AppSize.s20),
                  StreamBuilder<bool>(
                    stream: _viewModel.areAllInputsValidOutput,
                    builder: (context, snapshot) {
                      log(snapshot.data.toString());
                      return PublicButton(
                        title: AppStrings.login,
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.login();
                              }
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetPassword);
                        },
                        child: const PublicText(
                          txt: AppStrings.forgetPassword,
                          color: AppColors.orange,
                          size: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        child: const PublicText(
                          txt: AppStrings.notMemeberSignUp,
                          color: AppColors.orange,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
