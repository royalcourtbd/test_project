import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:initial_project/core/static/constants.dart';
import 'package:initial_project/core/utility/trial_utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;

bool get isMobile => rs.Device.screenType == rs.ScreenType.mobile;
String? _currentAppVersion;

/// Helper extension that allows to use color with opacity like:
/// `context.color.primary.withOpacityInt(0.1)`
extension ColorOpacityExtension on Color {
  Color withOpacityInt(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}

/// Checks the internet connection asynchronously.
///
///
/// Example usage:
///
/// ```dart
/// bool isConnected = await checkInternetConnection();
/// if (isConnected) {
///   logDebug('Internet connection is available.');
/// } else {
///   logDebug('No internet connection.');
/// }
/// ```
///
/// Rationale:
///
/// The `checkInternetConnection` function provides a straightforward way to determine
/// the availability of an internet connection within your Flutter application. By performing
/// a lookup for a well-known URL, it checks if the device can successfully resolve the URL's
/// IP address, indicating an active internet connection.
///

Future<bool> checkInternetConnection() async {
  final bool? isConnected = await catchAndReturnFuture(() async {
    const String kLookUpUrl = 'www.cloudflare.com';
    final List<InternetAddress> result = await InternetAddress.lookup(
      kLookUpUrl,
    );
    if (result.isEmpty) return false;
    if (result.first.rawAddress.isEmpty) return false;
    return true;
  });
  return isConnected ?? false;
}

// const String reportEmailAddress = 'report.irdfoundation@gmail.com';
// const String donationUrl = 'https://irdfoundation.com/sadaqa-jaria.html';
// const String messengerUrl = "https://m.me/ihadis.official";
// const String twitterUrl = "https://twitter.com/irdofficial";
// const String facebookGroupUrl = "https://www.facebook.com/groups/irdofficial";
// const String facebookPageUrl = "https://www.facebook.com/ihadis.official";

// /// Returns the file path for the given [fileName] in the specified [directoryPath].
// ///
// /// If the file does not exist, it returns an empty string.
// Future<bool> fileExists(
//     {required String directoryPath, required String fileName}) async {
//   final String filePath = '$directoryPath/$fileName';
//   final bool isFileExists = await File(filePath).exists();
//   return isFileExists;
// }

// /// get application directory path
Future<String> getApplicationDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<String> get currentAppVersion async {
  if (_currentAppVersion == null) {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _currentAppVersion = packageInfo.version;
  }
  log('currentAppVersion: $_currentAppVersion');
  return _currentAppVersion!;
}

String get suitableAppStoreUrl =>
    Platform.isAndroid ? playStoreUrl : appStoreUrl;

// String get suitableAppStoreUrl =>
//     Platform.isAndroid ? playStoreUrl : appStoreUrl;

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
// Future<void> disposeKeyboard(
//     BuildContext context, TextEditingController editingController) async {
//   editingController.clear();
//   KeyboardService.dismiss(context: context);
// }

Null Function(Object _)? doNothing(_) => null;

// extension IntDateExtension on int? {
//   DateTime get fromTimestampToDateTime {
//     if (this == null) return DateTime.now();
//     final DateTime date = DateTime.fromMillisecondsSinceEpoch(this!);
//     return date;
//   }
// }

// Future<String> getDatabaseFilePath(String fileName) async {
//   final directoryPath = await getApplicationDirectoryPath();
//   return join(directoryPath, fileName);
// }

// /// this function will check the fileName
// /// if fileName mached with the file then it will return true else false
// bool isNonDefaultTafseer(String fileName) {
//   return ["bn_fmazid", "bn_kathir", "bn_tafsir_kathir_mujibor"]
//       .contains(fileName);
// }

// extension DateTimeExtension on DateTime {
//   int get toTimestamp => millisecondsSinceEpoch;
// }

String getFormattedCurrentDateWithDay() {
  return DateFormat('MMM dd, yyyy - EEEE').format(DateTime.now());
}

String getFormattedCurrentDate() {
  return DateFormat('MMM dd, yyyy').format(DateTime.now());
}

String getFormattedTime(DateTime? time) {
  return time != null ? DateFormat('hh:mm').format(time) : '--:--';
}

String getFormattedTimeForWaqtView(DateTime? time) {
  return time != null ? DateFormat('hh:mm').format(time) : '--:--';
}

String getFormattedTimeForFasting(DateTime? time) {
  return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
}

String getFormattedDate(DateTime? date, {String format = 'MMM dd, yyyy'}) {
  if (date == null) return '';
  return DateFormat(format).format(date);
}

String getFormattedDuration(Duration? duration) {
  if (duration == null) return '--:--';
  return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

// Future<void> updateTime({
//   required BuildContext context,
//   required String timeType,
//   required SettingsPresenter settingsPresenter,
// }) async {
//   final ThemeData theme = context.theme;
//   final TimeOfDay? newTime = await showTimePicker(
//     context: context,
//     initialEntryMode: TimePickerEntryMode.dialOnly,
//     initialTime: (timeType == 'startTime')
//         ? settingsPresenter.currentUiState.startTime
//         : settingsPresenter.currentUiState.endTime,
//     builder: (BuildContext context, Widget? child) {
//       return MediaQuery(
//         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//         child: Theme(
//           data: context.theme.copyWith(
//             timePickerTheme: TimePickerThemeData(
//               backgroundColor: theme.scaffoldBackgroundColor,
//               dialHandColor: theme.colorScheme.primary,
//               dialTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               dayPeriodColor: theme.colorScheme.primary,
//               hourMinuteColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return theme.primaryColor;
//                 }
//                 return theme.cardColor;
//               }),
//               hourMinuteTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               dayPeriodTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               shape: RoundedRectangleBorder(
//                 borderRadius: radius10,
//               ),
//             ),
//           ),
//           child: child!,
//         ),
//       );
//     },
//   );

//   if (newTime != null) {
//     if (timeType == 'startTime') {
//       await settingsPresenter.updateSettings(startTime: newTime);
//     } else {
//       await settingsPresenter.updateSettings(endTime: newTime);
//     }
//   }
// }
