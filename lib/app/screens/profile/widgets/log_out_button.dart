import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key, required this.onLogOutButtonPressed});

  final Function() onLogOutButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          onLogOutButtonPressed();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Log out',
              style: TextStyle(color: Colors.red, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
