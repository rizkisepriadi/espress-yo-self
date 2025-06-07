import 'dart:io';
import 'package:espress_yo_self/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/setting_button.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  Future<void> _initializeControllers() async {
    try {
      final currentUser = await ref.read(currentUserProvider.future);
      setState(() {
        _nameController.text = currentUser.name;
        _emailController.text = currentUser.email;
      });
    } catch (e) {
      debugPrint('Error initializing controllers: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to pick image: $e")),
        );
      }
    }
  }

  Future<void> _onSavePressed() async {
    if (_isLoading) return;

    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = await ref.read(currentUserProvider.future);
      final userRepository = ref.read(userRepositoryProvider);

      await userRepository.updateUserProfile(currentUser.id, name,
          profileImage: _selectedImage);

      ref.invalidate(currentUserProvider);
      ref.invalidate(
          getUserViewModelProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final userState = ref.watch(getUserViewModelProvider);
    final currentImage = userState.asData?.value.profileImageUrl;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
              color: colorScheme.onSurface, size: 35.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Profile",
          style: textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 58.r,
                        backgroundColor: colorScheme.surface,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (currentImage != null && currentImage.isNotEmpty)
                                ? NetworkImage(currentImage)
                                : null,
                        onBackgroundImageError:
                            (currentImage != null && currentImage.isNotEmpty)
                                ? (exception, stackTrace) {
                                    debugPrint(
                                        'Error loading background image: $exception');
                                  }
                                : null,
                        child: (_selectedImage == null &&
                                (currentImage == null || currentImage.isEmpty))
                            ? SvgPicture.asset(
                                "assets/svgs/profile_default.svg",
                                width: 140.w,
                                height: 140.h,
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: colorScheme.primary,
                          child: IconButton(
                            iconSize: 18.sp,
                            color: colorScheme.onPrimary,
                            onPressed: () {
                              _pickImage();
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Form Fields
                _textfield("Name*", textTheme, _nameController, colorScheme),
                SizedBox(height: 16.h),
                _textfield("Email*", textTheme, _emailController, colorScheme,
                    enabled: false),
                SizedBox(height: 16.h),
                _textfield(
                    "Phone Number", textTheme, _phoneController, colorScheme,
                    enabled: false),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 32.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SettingButton(
                label: _isLoading ? "Saving..." : "Save",
                onTap: _isLoading ? null : _onSavePressed,
                colorIcon: colorScheme.onPrimary,
                colorBackground: colorScheme.primary,
              ),
              SizedBox(height: 16.h),
              SettingButton(
                label: "Change Password",
                onTap: () {
                  // Handle change password
                },
                colorIcon: colorScheme.primary,
                isOutlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _textfield(String title, TextTheme textTheme,
      TextEditingController controller, ColorScheme colorScheme,
      {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: enabled,
          style: textTheme.bodyMedium?.copyWith(
            color: enabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withAlpha(153),
          ),
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade500,
                width: 1.w,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade500,
                width: 1.w,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.w,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.w,
              ),
            ),
            contentPadding: EdgeInsets.only(bottom: 8.h),
          ),
        ),
      ],
    );
  }
}
