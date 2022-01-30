import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key? key, required String title, required var context, required bool leading})
      : super(key: key, 
          title: Text(title),
          automaticallyImplyLeading: leading,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        );
}
