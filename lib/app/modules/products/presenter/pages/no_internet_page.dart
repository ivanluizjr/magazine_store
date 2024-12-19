import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magazine_store/app/core/routes/app_routes.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/no_internet.svg'),
                  const SizedBox(height: 20),
                  TextWidget.poppins(
                    text: 'Something went wrong!',
                    fontSize: 16,
                    colorText: const Color(0xff70797f),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () => Modular.to.pushNamed(AppRoutes.initialRoute),
              child: TextWidget.poppins(
                text: 'Go Home',
                fontSize: 16,
                colorText: const Color(0xff3366CC),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
