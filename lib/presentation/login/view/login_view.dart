import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';
import '../../resources/widgets/public_button.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../resources/constants/app_assets.dart';
import '../../resources/constants/app_values.dart';
import '../../resources/styles/app_colors.dart';
import '../../resources/widgets/Public_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewModel _viewModel = LoginViewModel(_loginUseCase);

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
        .addListener(() => _viewModel.setUserName(_passwordController.text));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return _getScaffold();
  }

  Widget _getScaffold() {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPading.p24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppAssets.splashLogo,
                    height: 200.h,
                  ),
                  StreamBuilder<bool>(
                      stream: _viewModel.isUserNameValidOutputs,
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
                      stream: _viewModel.isPasswordValidOutputs,
                      builder: (context, snapshot) {
                        return PublicTextFormField(
                          hint: AppStrings.password,
                          controller: _passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (_) => snapshot.data ?? true
                              ? null
                              : AppStrings.passwordError,
                        );
                      }),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  PublicButton(
                    title: AppStrings.login,
                    onPressed: () {
                      _viewModel.login();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _viewModel.dispose();
  //   _userNameController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
}
