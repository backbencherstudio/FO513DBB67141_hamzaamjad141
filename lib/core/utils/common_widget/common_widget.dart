import 'package:flutter/cupertino.dart';
import 'secondary_button/secondary_button.dart';

class CommonWidget {
  const CommonWidget._();

  static SecondaryButtonWidget secondaryButton({
    required Widget child,
    VoidCallback? onTap,
  }) => SecondaryButtonWidget(onTap: onTap, child: child);
}
