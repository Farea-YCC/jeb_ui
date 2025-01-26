import 'package:flutter/material.dart';
import 'package:jeb_ui/auth/register.dart';
import 'package:jeb_ui/all.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/services.dart';
import 'package:jeb_ui/bottomnavbar.dart';
import 'package:local_auth/local_auth.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePin = true;
  String _selectedAccountType = '';
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_onPinChanged);
  }

  void _onPinChanged() {
    setState(() {});
  }

  Future<void> _authenticateWithPin() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال رقم الموبايل")),
      );
      return;
    }

    // التحقق من الاتصال بالإنترنت
    bool hasInternet = await _checkInternetConnectionWithRetry();
    if (!hasInternet) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا يوجد اتصال بالإنترنت. تحقق من اتصالك.")),
      );
      return;
    }

    // التحقق من رمز PIN
    if (_pinController.text == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("رمز PIN غير صحيح")),
      );
    }
  }

  Future<void> authenticateWithBiometrics(BuildContext context) async {
    final LocalAuthentication localAuth = LocalAuthentication();
    try {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: "قم بتأكيد الهوية باستخدام البصمة",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        bool hasInternet = await _checkInternetConnectionWithRetry();

        if (hasInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم التحقق بنجاح")),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("خطأ في الاتصال"),
              content: const Text(
                  "لا يوجد اتصال بالإنترنت. تحقق من اتصالك وحاول مرة أخرى."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("حسناً"),
                ),
              ],
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("فشل التحقق")),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: ${e.message}")),
      );
    }
  }

  Future<bool> _checkInternetConnectionWithRetry() async {
    const int maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      bool hasConnection = await InternetConnectionCheckerPlus().hasConnection;
      if (hasConnection) {
        return true;
      }
      attempt++;
      await Future.delayed(const Duration(seconds: 2));
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/jaiblogo.png',
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'مرحبًا بعودتك ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'قم بتسجيل الدخول ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedAccountType = 'customer'),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedAccountType == 'customer'
                                ? Colors.black
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(width: 10),
                            Text('عميل'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedAccountType = 'sales_point'),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedAccountType == 'sales_point'
                                ? Colors.black
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.store_outlined),
                            SizedBox(width: 10),
                            Text('نقطة مبيعات'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'رقم الموبايل',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: _obscurePin,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'رمز PIN',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                suffixIcon: _pinController.text.isEmpty
                    ? IconButton(
                  onPressed: () {
                    authenticateWithBiometrics(context);
                  },
                  icon: const Icon(
                    Icons.fingerprint,
                    size: 30,
                    color: Colors.grey,
                  ),
                )
                    : IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePin = !_obscurePin;
                    });
                  },
                  icon: Icon(
                    _obscurePin ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _authenticateWithPin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kprimaryColor,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'إنشاء حساب',
                    style: TextStyle(color: AppColors.kprimaryColor),
                  ),
                ),
                const Text('لاتمتلك حساب؟'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}