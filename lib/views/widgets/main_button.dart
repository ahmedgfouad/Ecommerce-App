import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.hasCirclarBorder = false,
  });
  final String text;
  final VoidCallback onTap;
  final bool hasCirclarBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor, 
          shape:
              hasCirclarBorder
                  ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )
                  : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
