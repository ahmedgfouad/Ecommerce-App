import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    super.key,
    this.text,
    this.onTap,
    this.hasCirclarBorder = false,
    this.child,
  }) {
    assert(text != null || child != null);
  }
  final String? text;
  final VoidCallback? onTap;
  final bool hasCirclarBorder;
  final Widget? child;

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
        child:
            text != null
                ? Text(
                  text!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                )
                : child,
      ),
    );
  }
}
