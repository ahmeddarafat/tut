import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/data/data_source/local_data_source.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';
import 'package:tut/presentation/resources/router/app_router.dart';
import 'package:tut/presentation/resources/styles/app_colors.dart';
import 'package:tut/presentation/resources/widgets/public_text.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPrefs _appPrefs = getIt<AppPrefs>();
  final LocalDataSource _localDataSource = getIt<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
           ListTileSettings(
            title: AppStrings.changeLanguage.tr(),
            icon: Icons.language_outlined,
            onTap: ()=> _changeLanguage(),
          ),
          const Divider(color: AppColors.grey),
           ListTileSettings(
            title: AppStrings.contactUs.tr(),
            icon: Icons.contactless,
            onTap: (){},
          ),
          const Divider(color: AppColors.grey),
           ListTileSettings(
            title: AppStrings.inviteYourFriends.tr(),
            icon: Icons.share,
            onTap: (){},
          ),
          const Divider(color: AppColors.grey),
           ListTileSettings(
            title: AppStrings.logout.tr(),
            icon: Icons.logout,
            onTap: ()=>_logout(),
          ),
        ],
      ),
    );
  }

  void _changeLanguage(){
    _appPrefs.changeAppLanguage();
    Phoenix.rebirth(context);

  }

  void _logout(){
    _localDataSource.clearCache();
    _appPrefs.logout();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}

class ListTileSettings extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const ListTileSettings(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.orange,
        ),
        title: PublicText(
          txt: title,
          color: AppColors.grey,
          size: 16,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.orange,
        ),
      ),
    );
  }
}
