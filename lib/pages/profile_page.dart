import 'package:attandance_management_system/components/my_button.dart';
import 'package:attandance_management_system/components/my_textfield.dart';
import 'package:attandance_management_system/services/profile/profile_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getuserDetail();
  }

  void getuserDetail() async {
    ProfileService service = ProfileService();
    final providerData = await service.getUserInformation();
    for (final providerProfile in providerData) {
      // Name, email address, and profile photo URL
      nameController.text = providerProfile.displayName.toString();
      emailController.text = providerProfile.email.toString();
      // final profilePhoto = providerProfile.photoURL;
    }
  }

  void saveUserDetail() async {
    ProfileService service = ProfileService();
    try {
      service.updateUserInformation(nameController.text, emailController.text);
    } catch (e) {
      print(e);
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
            const CircleAvatar(
              radius: 120.0,
              backgroundImage: NetworkImage(
                  "https://static.vecteezy.com/system/resources/previews/004/476/164/original/young-man-avatar-character-icon-free-vector.jpg"),
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
