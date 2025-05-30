import 'package:flutter/material.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/forget_password/check_email/check_email.dart';

class ForgetPasswordBottomSheet extends StatefulWidget {
  const ForgetPasswordBottomSheet({super.key});

  @override
  State<ForgetPasswordBottomSheet> createState() =>
      _ForgetPasswordBottomSheetState();
}

class _ForgetPasswordBottomSheetState extends State<ForgetPasswordBottomSheet> {
  bool isEmailSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: MyTheme.grayColor2,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          Text("Forget Password?",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: MyTheme.orangeColor, fontSize: 20)),
          const SizedBox(height: 8),
          Text(
            "Choose how you want to reset your password",
            style: TextStyle(
              fontSize: 14,
              color: MyTheme.grayColor2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                isEmailSelected = !isEmailSelected;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isEmailSelected
                    ? MyTheme.orangeColor.withOpacity(0.15)
                    : MyTheme.grayColor3,
                border: Border.all(
                  color: isEmailSelected
                      ? MyTheme.orangeColor
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.email_outlined, color: MyTheme.orangeColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Reset via Email",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Icon(
                    isEmailSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isEmailSelected
                        ? MyTheme.orangeColor
                        : MyTheme.grayColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isEmailSelected
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPassword()),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isEmailSelected ? MyTheme.orangeColor : MyTheme.grayColor2,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: isEmailSelected ? 4 : 0,
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.whiteColor),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
