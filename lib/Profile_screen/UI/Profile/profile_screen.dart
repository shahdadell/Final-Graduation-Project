import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:graduation_project/Profile_screen/UI/Addresses/addresses_screen.dart';
import 'package:graduation_project/Profile_screen/UI/Profile/edit_profile_screen.dart';
import 'package:graduation_project/Profile_screen/UI/Profile/profile_widgets.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_state.dart';
import 'package:graduation_project/Profile_screen/data/auth_utils.dart';
import 'package:graduation_project/Profile_screen/data/repo/profile_repo.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<int?>(
      future: AuthUtils.getUserIdDirectly(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: MyTheme.orangeColor),
            ),
          );
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return Scaffold(
            appBar: _buildAppBar(context, textTheme),
            body: Center(
              child: Text(
                "Error loading user ID or not logged in",
                style: textTheme.titleMedium
                    ?.copyWith(color: MyTheme.grayColor2, fontSize: 14.sp),
              ),
            ),
          );
        } else {
          final userId = snapshot.data!.toString();
          return BlocProvider(
            create: (context) =>
                ProfileBloc(ProfileRepo())..add(FetchProfileEvent(userId)),
            child: Scaffold(
              appBar: _buildAppBar(context, textTheme),
              body: Container(
                color: MyTheme.whiteColor,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: MyTheme.orangeColor),
                      );
                    } else if (state is ProfileLoaded) {
                      final profile = state.profile.data;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildProfileImage(profile?.usersImage, false),
                              SizedBox(height: 16.h),
                              _buildProfileCard(context, profile),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildButton(
                                    context,
                                    text: "Edit Profile",
                                    color: MyTheme.orangeColor,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        EditProfileScreen.routeName,
                                        arguments: {
                                          'userId': userId,
                                          'profile': profile,
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(width: 12.w),
                                  _buildButton(
                                    context,
                                    text: "Log Out",
                                    color: MyTheme.redColor,
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.scale,
                                        title: 'Log Out',
                                        desc:
                                            'Are you sure you want to log out?',
                                        btnCancelText: 'Cancel',
                                        btnOkText: 'Log Out',
                                        btnCancelColor: MyTheme.grayColor,
                                        btnOkColor: MyTheme.redColor,
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          await AppLocalStorage.clearData();
                                          Navigator.pushReplacementNamed(
                                            context,
                                            MainScreen.routName,
                                          );
                                        },
                                      ).show();
                                    },
                                  ).animate().shake(duration: 600.ms, hz: 2),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is ProfileError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Error: ${state.message}",
                              style: textTheme.titleMedium?.copyWith(
                                  color: MyTheme.redColor, fontSize: 14.sp),
                            ),
                            SizedBox(height: 16.h),
                            _buildButton(
                              context,
                              text: "Retry",
                              color: MyTheme.orangeColor,
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(FetchProfileEvent(userId));
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: _buildButton(
                        context,
                        text: "Load Profile",
                        color: MyTheme.orangeColor,
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FetchProfileEvent(userId));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, TextTheme textTheme) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: MyTheme.whiteColor,
            size: 24.w,
          ),
        ),
      ),
      title: Text(
        "My Profile",
        style: textTheme.displayLarge?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: MyTheme.whiteColor,
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(
            begin: 0.1,
            end: 0.0,
            duration: 400.ms,
            curve: Curves.easeOut,
          ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic profile) {
    final nameController =
        TextEditingController(text: profile?.usersName ?? '');
    final emailController =
        TextEditingController(text: profile?.usersEmail ?? '');
    final phoneController =
        TextEditingController(text: profile?.usersPhone ?? '');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyTheme.grayColor3.withOpacity(0.2),
            blurRadius: 8.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditableField(context, "Name", nameController, Icons.person),
          buildEditableField(context, "Email", emailController, Icons.email),
          buildEditableField(context, "Phone", phoneController, Icons.phone),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.center,
            child: _buildButton(
              context,
              text: "My Addresses",
              color: MyTheme.orangeColor,
              icon: Icons.location_on,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressesScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(
          begin: 0.1,
          end: 0.0,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildButton(
    BuildContext context, {
    required String text,
    required Color color,
    VoidCallback? onPressed,
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 3,
        shadowColor: MyTheme.grayColor3.withOpacity(0.4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: MyTheme.whiteColor, size: 16.w),
            SizedBox(width: 6.w),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 14.sp,
                  color: MyTheme.whiteColor,
                ),
          ),
        ],
      ),
    )
        .animate(
          effects: [
            const ScaleEffect(
              begin: Offset(1.0, 1.0),
              end: Offset(1.05, 1.05),
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ],
        )
        .then()
        .scale(
          begin: const Offset(1.05, 1.05),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }
}
