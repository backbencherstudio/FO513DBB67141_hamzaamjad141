import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'secondary_button/secondary_button.dart';

class CommonWidget {
  const CommonWidget._();

  static SecondaryButtonWidget secondaryButton({
    required Widget child,
    VoidCallback? onTap,
  }) => SecondaryButtonWidget(onTap: onTap, child: child);

  static Widget primaryButton({
    required VoidCallback onTap,
    required String bodyText,
    bool isSecondary = false,
    bool isActive = true,
  }) => PrimaryButton(
    onTap: onTap,
    bodyText: bodyText,
    isActive: isActive,
    isSecondary: isSecondary,
  );
}
