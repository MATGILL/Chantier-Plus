import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
