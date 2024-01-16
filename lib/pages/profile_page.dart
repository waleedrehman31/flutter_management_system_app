// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:attandance_management_system/components/my_alertdialog.dart';
import 'package:attandance_management_system/components/my_button.dart';
import 'package:attandance_management_system/components/my_textfield.dart';
import 'package:attandance_management_system/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String profilePhoto = "";
  String? photoUrl = "";

  @override
  void initState() {
    getuserDetail();
    super.initState();
  }

  void getuserDetail() async {
    ProfileService service = ProfileService();
    final providerData = await service.getUserInformation();
    for (final providerProfile in providerData) {
      // Name, email address, and profile photo URL
      nameController.text = providerProfile.displayName.toString();
      emailController.text = providerProfile.email.toString();
      setState(() {
        profilePhoto = providerProfile.photoURL.toString();
      });
    }
  }

  uploadImage() async {
    final imagePicker = ImagePicker();
    XFile? image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await imagePicker.pickImage(source: ImageSource.gallery);
      File file = File(image!.path);
      String imageName = image.name;
      photoUrl = (await ProfileService().getImageUrl(file, imageName))!;
      setState(() {
        profilePhoto = photoUrl.toString();
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => const MyAlertDialog(
              title: "Error",
              content:
                  "Permission not granted. Try Again with permission access"));
    }
  }

  void saveUserDetail() async {
    ProfileService service = ProfileService();
    //Check Permission
    try {
      service.updateUserInformation(
          nameController.text, emailController.text, profilePhoto);
      showDialog(
          context: context,
          builder: (context) => const MyAlertDialog(
              title: "Successfull",
              content: "Information Update Successfully"));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              MyAlertDialog(title: "Error", content: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 120.0,
              // backgroundImage: NetworkImage(profilePhoto),
              backgroundImage: (profilePhoto == "")
                  ? const NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/004/476/164/original/young-man-avatar-character-icon-free-vector.jpg')
                  : NetworkImage(profilePhoto),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text("Upload Profile Image"),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(text: "Save", onTap: saveUserDetail),
          ],
        ),
      ),
    );
  }
}
