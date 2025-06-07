import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingButton extends ConsumerStatefulWidget {
  const SettingButton({
    super.key,
    this.icon,
    required this.label,
    this.onTap,
    this.colorIcon,
    this.colorBackground,
    this.isToggle = false,
    this.toggleValue = false,
    this.onToggleChanged,
    this.isOutlined = false,
  });

  final VoidCallback? onTap;
  final IconData? icon;
  final String label;
  final Color? colorIcon;
  final Color? colorBackground;
  final bool isToggle;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final bool isOutlined;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingButtonState();
}

class _SettingButtonState extends ConsumerState<SettingButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (widget.isOutlined) {
      return SizedBox(
        width: 380.w,
        height: 50.h,
        child: OutlinedButton(
          onPressed: widget.isToggle ? null : widget.onTap,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: widget.colorBackground ?? colorScheme.primary,
              width: 2.w,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            backgroundColor: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: widget.icon != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              // Icon
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.colorIcon ?? colorScheme.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 16.w),
              ],

              // Text
              widget.icon != null
                  ? Expanded(
                      child: Text(
                        widget.label,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: widget.colorIcon ?? colorScheme.primary,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Text(
                      widget.label,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.colorIcon ?? colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),

              // Toggle Switch or Spacer
              if (widget.isToggle)
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: widget.toggleValue,
                    onChanged: widget.onToggleChanged,
                    activeColor: colorScheme.primary,
                  ),
                )
              else if (widget.icon != null)
                SizedBox(width: 50.w),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.isToggle ? null : widget.onTap,
      child: Container(
        width: 380.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: widget.colorBackground ?? colorScheme.surface,
          border: Border.all(
            color: widget.colorBackground ?? colorScheme.outline,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: widget.icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            // Icon
            if (widget.icon != null) ...[
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Icon(
                  widget.icon,
                  color: widget.colorIcon ?? colorScheme.onSurface,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
            ],

            // Text
            widget.icon != null
                ? Expanded(
                    child: Text(
                      widget.label,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.colorIcon ?? colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  )
                : Text(
                    widget.label,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: widget.colorIcon ?? colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),

            // Toggle Switch or Spacer
            if (widget.isToggle)
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: widget.toggleValue,
                    onChanged: widget.onToggleChanged,
                    activeColor: colorScheme.primary,
                  ),
                ),
              )
            else if (widget.icon != null)
              SizedBox(width: 50.w),
          ],
        ),
      ),
    );
  }
}
