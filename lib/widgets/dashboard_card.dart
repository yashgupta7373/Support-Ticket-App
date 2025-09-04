import 'package:flutter/material.dart';
import '../utils/colors.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontFamily: 'UbuntuBold',
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
