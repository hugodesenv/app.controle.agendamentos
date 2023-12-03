import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class DialogsUtil {
  static Future<void> confirmation(
    BuildContext pContext,
    String pTitle,
    String? pMessage,
    Function() onSim, {
    Function()? onNao,
  }) async {
    await Dialogs.materialDialog(
      context: pContext,
      title: pTitle,
      msg: pMessage,
      titleStyle: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w700,
      ),
      msgStyle: const TextStyle(color: Colors.black54),
      actions: [
        IconsButton(
          onPressed: () => onSim(),
          text: 'Sim',
          iconData: Icons.exit_to_app_outlined,
          color: Theme.of(pContext).primaryColor,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
        IconsOutlineButton(
          onPressed: () {
            if (onNao != null) {
              onNao();
            }
            Navigator.pop(pContext);
          },
          text: 'Não',
          iconData: Icons.cancel_outlined,
          textStyle: const TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
      ],
    );
  }
}
