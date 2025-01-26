// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:local_auth/local_auth.dart';
// import 'BottomNavBar.dart';
//
// Future<void> authenticateWithBiometrics(BuildContext context) async {
//   final LocalAuthentication localAuth = LocalAuthentication();
//   try {
//     // Step 1: Biometric Authentication
//     bool isAuthenticated = await localAuth.authenticate(
//       localizedReason: "قم بتأكيد الهوية باستخدام البصمة",
//       options: const AuthenticationOptions(
//         stickyAuth: true,
//         biometricOnly: true,
//       ),
//     );
//
//     if (isAuthenticated) {
//       // Step 2: Check Internet Connection
//       bool hasInternet = await InternetConnectionCheckerPlus().hasConnection;
//       if (!hasInternet) {
//         // Retry internet check after a short delay
//         await Future.delayed(const Duration(milliseconds: 100));
//         hasInternet = await InternetConnectionCheckerPlus().hasConnection;
//       }
//
//       if (hasInternet) {
//         // Success: Show success message and navigate to BottomNavBar
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("تم التحقق بنجاح")),
//         );
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const BottomNavBar(),
//           ),
//         );
//       } else {
//         // Failure: No internet connection
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("خطأ في الاتصال"),
//             content: const Text(
//                 "لا يوجد اتصال بالإنترنت. تحقق من اتصالك وحاول مرة أخرى."),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text("حسناً"),
//               ),
//             ],
//           ),
//         );
//       }
//     } else {
//       // Biometric Authentication failed
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("فشل التحقق")),
//       );
//     }
//   } on PlatformException catch (e) {
//     // Handle platform-specific exceptions
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("حدث خطأ: ${e.message}")),
//     );
//   }
// }