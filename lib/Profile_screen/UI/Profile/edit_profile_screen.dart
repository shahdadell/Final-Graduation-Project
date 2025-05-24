import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/Profile_screen/UI/Profile/profile_widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repo/profile_repo.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile-screen';
  final String userId;
  final dynamic profile;

  const EditProfileScreen(
      {super.key, required this.userId, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _image; // متغير لتخزين الصورة المختارة
  final ImagePicker _picker = ImagePicker(); // Instance من ImagePicker

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.profile?.usersName ?? '');
    _emailController =
        TextEditingController(text: widget.profile?.usersEmail ?? '');
    _phoneController =
        TextEditingController(text: widget.profile?.usersPhone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // دالة لاختيار الصورة من المعرض أو الكاميرا
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // دالة لعرض خيارات اختيار الصورة
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: MyTheme.orangeColor),
                title: Text('Choose from Gallery',
                    style: Theme.of(context).textTheme.bodyMedium),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: MyTheme.orangeColor),
                title: Text('Take a Photo',
                    style: Theme.of(context).textTheme.bodyMedium),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _validateFields() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty")),
      );
      return false;
    }
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email cannot be empty")),
      );
      return false;
    }
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return false;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone cannot be empty")),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ProfileBloc(ProfileRepo()),
      child: Scaffold(
        appBar: _buildAppBar(context, textTheme),
        body: Container(
          color: MyTheme.whiteColor,
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdated) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.scale,
                  title: 'Success',
                  desc: 'Profile updated successfully',
                  btnOkText: 'OK',
                  btnOkColor: MyTheme.orangeColor,
                  btnOkOnPress: () => Navigator.pop(context),
                ).show();
              } else if (state is ProfileError) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: state.message,
                  btnOkText: 'OK',
                  btnOkColor: MyTheme.redColor,
                  btnOkOnPress: () {},
                ).show();
              }
            },
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.orangeColor),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:
                            _showImagePickerOptions, // إظهار خيارات اختيار الصورة
                        child: _image != null
                            ? Stack(
                                children: [
                                  Container(
                                    width: 130.w,
                                    height: 130.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: MyTheme.orangeColor2,
                                          width: 3.w),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10.r,
                                          spreadRadius: 2.r,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: MyTheme.orangeColor,
                                      child: Icon(Icons.camera_alt,
                                          color: MyTheme.whiteColor,
                                          size: 20.w),
                                    ),
                                  ),
                                ],
                              )
                            : buildProfileImage(
                                widget.profile?.usersImage, true),
                      ),
                      SizedBox(height: 16.h),
                      _buildProfileCard(context),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildButton(
                            context,
                            text: "Save Changes",
                            color: MyTheme.orangeColor,
                            onPressed: () {
                              if (_validateFields()) {
                                context.read<ProfileBloc>().add(
                                      UpdateProfileEvent(
                                        widget.userId,
                                        _nameController.text,
                                        _emailController.text,
                                        _phoneController.text,
                                        image: _image, // إرسال الصورة المختارة
                                      ),
                                    );
                              }
                            },
                          ),
                          SizedBox(width: 12.w),
                          _buildButton(
                            context,
                            text: "Cancel",
                            color: MyTheme.grayColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
      ).animate().scale(duration: 200.ms, curve: Curves.easeInOut),
      title: Text(
        "Edit Profile",
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

  Widget _buildProfileCard(BuildContext context) {
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
          buildEditableField(context, "Name", _nameController, Icons.person,
              isEditing: true),
          buildEditableField(context, "Email", _emailController, Icons.email,
              isEditing: true),
          buildEditableField(context, "Phone", _phoneController, Icons.phone,
              isEditing: true),
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
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 14.sp,
              color: MyTheme.whiteColor,
            ),
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
