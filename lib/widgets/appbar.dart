import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/models/user.dart' as model;

import 'package:flutter/material.dart';

import '../providers/user_provider.dart';
import '../screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            child: (FirebaseAuth.instance.currentUser!.isAnonymous == true)
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/default_profile_pic.png'),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoUrl),
                  ),
          ),
        )
      ],
    );
  }
}
