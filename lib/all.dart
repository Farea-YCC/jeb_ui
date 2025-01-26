import 'package:flutter/material.dart';
class AppColors {
  static const Color kContentColor = Color(0xfffdfdfd);
  static const Color kConteDDDDDntColor = Color(0xFFFEF7FF);
  static const Color kContenBBBBtColor = Color(0xFF141218);
  static const Color kscaffoldBackgroundColor = Color(0xfff1f0f5);
  static const Color kprimaryColor = Color(0xffcb0a09);
  static const Color kTextAndIconColor = Color(0xFF1C3941);
  static const Color kunselectedItemColor = Color(0xFF8E8D90);
  static const Color kunselecgggtedItemColor = Color(0xFFBDBDBE);
}
class CustomVersion extends StatelessWidget {
  const CustomVersion({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'V 2.6',
        style: TextStyle(color: AppColors.kTextAndIconColor, fontSize: 18),
      ),
    );
  }
}
class CustomUserData extends StatelessWidget {
  final String userName;
  final String accountNumber;
  final String alternateNumber;

  const CustomUserData({
    super.key,
    required this.userName,
    required this.accountNumber,
    required this.alternateNumber,
  });

  Widget _buildAccountInfo(String label, String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kContentColor)),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.kContentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.kContentColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.kTextAndIconColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.kprimaryColor, width: 3),
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.kContentColor,
                  child: Icon(Icons.person_outline,
                      size: 40, color: AppColors.kprimaryColor),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: AppColors.kprimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _buildAccountInfo('رقم الحساب', accountNumber),
                const VerticalDivider(
                  color: AppColors.kContentColor,
                  width: 1,
                  thickness: 1,
                ),
                _buildAccountInfo('الرقم البديل', alternateNumber),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kTextAndIconColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                  const Icon(Icons.qr_code, color: AppColors.kContentColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Add Product Page'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cart Page'),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
