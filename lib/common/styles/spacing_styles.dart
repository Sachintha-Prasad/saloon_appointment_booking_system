import 'package:flutter/cupertino.dart';
import 'package:saloon_appointment_booking_system/utils/constants/sizes.dart';

class SBSpacingStyle {
  SBSpacingStyle._();

  static const EdgeInsetsGeometry paddingMainLayout = EdgeInsets.only(
    top: SBSizes.xl,
    left: SBSizes.defaultSpace,
    bottom: SBSizes.defaultSpace,
    right: SBSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingAuthLayout = EdgeInsets.only(
    top: 96.0,
    left: SBSizes.defaultSpace,
    bottom: SBSizes.defaultSpace,
    right: SBSizes.defaultSpace,
  );
}
