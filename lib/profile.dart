import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeb_ui/widget/CustomHeader.dart';
import 'package:jeb_ui/widget/CustomLogoutDialog.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'as p;
import 'all.dart';
import 'core/myapp/my_app.dart';
import 'language_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buildExpandableMenuItem(
      IconData icon, String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.kContentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        iconColor: AppColors.kTextAndIconColor,
        showTrailingIcon: true,
        leading: Icon(
          icon,
          color: AppColors.kTextAndIconColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.kTextAndIconColor,
          ),
        ),
        children: List.generate(children.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Divider(
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.kTextAndIconColor.withOpacity(0.3),
            );
          } else {
            return children[index ~/ 2];
          }
        }),
      ),
    );
  }

  Widget _buildSubMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.kTextAndIconColor),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.kContentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color:
          isLogout ? AppColors.kprimaryColor : AppColors.kTextAndIconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout
                ? AppColors.kprimaryColor
                : AppColors.kTextAndIconColor,
          ),
        ),
        onTap: () {
          if (isLogout) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomLogoutDialog(
                  context,
                  onLogout: () {
                    Navigator.pop(context);
                    SystemNavigator.pop();
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: [
        _buildMenuItem(Icons.update, 'تحديث بيانات التطبيق'),
        _buildMenuItem(Icons.phone_android, 'ادارة الأجهزة'),
        _buildExpandableMenuItem(
          Icons.security,
          'الخصوصية والأمان',
          [
            _buildSubMenuItem(Icons.phone, 'تغيير رمز التاكيد', () {}),
            _buildSubMenuItem(Icons.lock, 'تغيير كلمة المرور', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            }),
            _buildSubMenuItem(
                Icons.fingerprint_outlined, 'استخدم البصمة لتسجيل الدخول ', () {}),
            _buildSubMenuItem(Icons.security, ' اخفاء الاقتراخات ', () {}),
            _buildSubMenuItem(Icons.info, 'الشروط والاحكام', () {}),
          ],
        ),
        _buildExpandableMenuItem(
          Icons.headset_mic,
          'الدعم والمساعدة',
          [
            _buildSubMenuItem(Icons.phone, '8008005', () {}),
            _buildSubMenuItem(Icons.location_on_outlined, 'نقاط الخدمة', () {}),
            _buildSubMenuItem(Icons.support_agent, 'خدمة العملاء', () {}),
          ],
        ),
        _buildMenuItem(Icons.share, 'شارك تطبيق جيب'),
        _buildMenuItem(Icons.sunny, 'مظهر التطبيق'),
        _buildLanguageSwitcher(context),
        _buildMenuItem(Icons.delete_outline, 'طلب الغاء المحفظة'),
        _logoutMenuItem(),
      ],
    );
  }

  Widget _logoutMenuItem() {
    return _buildMenuItem(
      Icons.logout,
      'تسجيل الخروج',

      isLogout: true,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.kscaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomHeader(
                  userName: 'فارع',
                ),
                const CustomUserData(
                  userName: 'فارع عبده فارع محمد الضلاع',
                  accountNumber: '717281413',
                  alternateNumber: '886368',
                ),
                _buildMenuItems(),
                const CustomVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.kContentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(
          l10n.changeLanguage,
        ),
        onTap: () {
          _showLanguageDialog(context);
        },
      ),
    );
  }
  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // يتيح التحكم في ارتفاع النافذة المنبثقة
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0), // رفع النافذة قليلاً عن الحافة السفلية
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.kContentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 24),
                      Text(
                        l10n.selectlanguage,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        color: const Color(0xFF222222),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(l10n.arabic),
                    onTap: () {
                      context
                          .read<LocaleProvider>()
                          .setLocale(const Locale('ar', 'AE'));
                      MyApp.setLocale(context, const Locale('ar', 'AE'));
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(l10n.english),
                    onTap: () {
                      context
                          .read<LocaleProvider>()
                          .setLocale(const Locale('en', 'US'));
                      MyApp.setLocale(context, const Locale('en', 'US'));
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'jeb.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<String?> getStoredPassword() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
    await db.query('users', columns: ['password'], limit: 1);
    if (result.isNotEmpty) {
      return result.first['password'];
    }
    return null;
  }

  Future<void> updatePassword(String newPassword) async {
    final db = await database;
    await db.update('users', {'password': newPassword});
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغيير كلمة المرور'),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور القديمة',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('تغيير كلمة المرور'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    if (_oldPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    final storedPassword = await _dbHelper.getStoredPassword();
    if (storedPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء جلب كلمة المرور')),
      );
      return;
    }

    if (_oldPasswordController.text != storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور القديمة غير صحيحة')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    // تحديث كلمة المرور في قاعدة البيانات
    await _dbHelper.updatePassword(_newPasswordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
    );

    _clearFields();
  }

  void _clearFields() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
