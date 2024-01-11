import 'package:attandance_management_system/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //Logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.system_security_update_good_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 62,
                  ),
                ),
              ),

              // home list
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G"),
                  leading: const Icon(Icons.settings),
                  onTap: () {},
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),

          // logout
        ],
      ),
    );
  }
}
