import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key, required this.onLogOutButtonPressed});

  final Function onLogOutButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          onLogOutButtonPressed();
        },
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
            AppLocalizations.of(context)!.log_out,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
