import 'package:firebase_provider/helper/HelperColor.dart';
import 'package:firebase_provider/widget/WidgetText.dart';
import 'package:flutter/material.dart';

import 'WIdgetTextField.dart';

enum EnumButtonWidth { max, min }

enum EnumButtonType {
  textButton,
  filledButton,
  outLinedButton,
  bgOutLinedButton
}

class WidgetButtonController {
  VoidCallback? success;
  VoidCallback? reset;
  VoidCallback? error;
  VoidCallback? loading;

  void dispose() {
    success = null;
    reset = null;
    error = null;
    loading = null;
  }
}

class WidgetButton extends StatefulWidget {
  final IconData? frontIcon;
  final IconData? backIcon;
  final Widget? widgetFrontIcon;
  final Widget? widgetBackIcon;
  final String? frontIconUrl;
  final String? backIconUrl;
  final String? title;
  final TextStyle? textStyle;
  final Color? color;
  final Color? progressColor;
  final BorderSide? borders;
  final Function? onPressed;
  final OutlinedBorder? borderRadius;
  final EnumWidgetSize? size;
  final EnumButtonWidth? enumButtonWidth;
  final WidgetButtonController? controller;
  final EnumButtonType? enumButtonType;
  final Color? iconColor;
  final double? iconSize;
  final Widget? titleText;
  WidgetButton(
      {Key? key,
      this.frontIcon,
      this.backIcon,
      this.title,
      this.textStyle,
      this.color,
      this.borders,
      this.borderRadius,
      this.size,
      this.enumButtonWidth,
      this.controller,
      this.enumButtonType,
      required this.onPressed,
      this.widgetFrontIcon,
      this.widgetBackIcon,
      this.progressColor,
      this.iconColor,
      this.frontIconUrl,
      this.backIconUrl,
      this.iconSize,
      this.titleText})
      : super(key: key);

  @override
  State<WidgetButton> createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  WidgetButtonController? controller;
  bool isPressed = false;
  bool isErrorOccured = false;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();

    controller = widget.controller;
    if (controller != null) {
      controller!.loading = loading;
      controller!.success = success;
      controller!.reset = reset;
      controller!.error = error;
    }
  }

  success() {
    setState(() {
      isSuccess = true;
      isErrorOccured = false;
      isPressed = false;
    });
  }

  loading() {
    setState(() {
      isPressed = true;
      isErrorOccured = false;
      isSuccess = false;
    });
  }

  reset() {
    setState(() {
      isPressed = false;
      isErrorOccured = false;
      isSuccess = false;
    });
  }

  error() {
    setState(() {
      isPressed = false;
      isErrorOccured = true;
      isSuccess = false;
    });
  }

  Widget child({icon}) {
    return icon != null
        ? Icon(
            icon,
            color: () {
              switch (widget.enumButtonType) {
                case EnumButtonType.filledButton:
                  return Colors.white;
                case EnumButtonType.textButton:
                  return isErrorOccured ? Colors.red : Colors.green;
                case EnumButtonType.outLinedButton:
                  return isErrorOccured ? Colors.red : Colors.green;
                case EnumButtonType.bgOutLinedButton:
                  return isErrorOccured ? Colors.red : Colors.green;
                default:
                  return Colors.white;
              }
            }(),
            size: iconHeightWidth(),
          )
        : widget.titleText != null
            ? widget.titleText!
            : Text(
                widget.title == null ? "Title" : widget.title!,
                style: widget.textStyle != null
                    ? widget.textStyle!
                    : textStyle(
                        textColor: widget.enumButtonType ==
                                    EnumButtonType.filledButton ||
                                widget.enumButtonType == null
                            ? HelperColor.colorBackGround
                            : Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w600,
                        fontSize: () {
                          switch (widget.size) {
                            case EnumWidgetSize.lr:
                              return 17.0;
                            case EnumWidgetSize.md:
                              return 15.0;
                            case EnumWidgetSize.sm:
                              return 12.0;
                            default:
                              return 15.0;
                          }
                        }()),
              );
  }

  double? iconHeightWidth() {
    switch (widget.size) {
      case EnumWidgetSize.lr:
        return 30;
      case EnumWidgetSize.md:
        return 24;
      case EnumWidgetSize.sm:
        return 15;
      default:
        return 20;
    }
  }

  double? heightWidth() {
    switch (widget.size) {
      case EnumWidgetSize.lr:
        return 27;
      case EnumWidgetSize.md:
        return 17;
      case EnumWidgetSize.sm:
        return 10;
      default:
        return 15;
    }
  }

  double? height() {
    switch (widget.size) {
      case EnumWidgetSize.lr:
        return 48;
      case EnumWidgetSize.md:
        return 40;
      case EnumWidgetSize.sm:
        return 32;
      default:
        return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(),
      child: ElevatedButton(
        child: Row(
          mainAxisSize: () {
            switch (widget.enumButtonWidth) {
              case EnumButtonWidth.max:
                return MainAxisSize.max;
              case EnumButtonWidth.min:
                return MainAxisSize.min;
              default:
                return MainAxisSize.min;
            }
          }(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isPressed == true && isErrorOccured == false && isSuccess == false
                ? SizedBox(
                    height: heightWidth(),
                    width: heightWidth(),
                    child: CircularProgressIndicator(
                      strokeWidth: () {
                        switch (widget.size) {
                          case EnumWidgetSize.lr:
                            return 4.0;
                          case EnumWidgetSize.md:
                            return 4.0;
                          case EnumWidgetSize.sm:
                            return 3.0;
                          default:
                            return 3.0;
                        }
                      }(),
                      backgroundColor: Colors.white,
                      valueColor: widget.color == null
                          ? widget.progressColor != null
                              ? AlwaysStoppedAnimation(widget.progressColor)
                              : AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColorDark)
                          : widget.progressColor != null
                              ? AlwaysStoppedAnimation(widget.progressColor)
                              : AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColorDark),
                    ),
                  )
                : Center(
                    child: child(
                        icon: isErrorOccured
                            ? Icons.error_outline
                            : isSuccess
                                ? Icons.check_circle
                                : null),
                  ),
          ],
        ),
        onPressed:
            isPressed == true && isErrorOccured == false && isSuccess == false
                ? null
                : widget.onPressed == null
                    ? null
                    : () {
                        if (!isSuccess) {
                          if (!isErrorOccured) {
                            widget.onPressed!();
                          }
                        }
                      },
        style: ElevatedButton.styleFrom(
            elevation:
                widget.enumButtonType == EnumButtonType.filledButton ? 1 : 0,
            side: () {
              switch (widget.enumButtonType) {
                case EnumButtonType.filledButton:
                  return widget.borders;
                case EnumButtonType.textButton:
                  return null;
                case EnumButtonType.outLinedButton:
                  return isErrorOccured
                      ? const BorderSide(color: Colors.red)
                      : isSuccess
                          ? const BorderSide(color: Colors.green)
                          : widget.borders ??
                              BorderSide(color: Theme.of(context).primaryColor);
                case EnumButtonType.bgOutLinedButton:
                  return isErrorOccured
                      ? const BorderSide(color: Colors.red)
                      : isSuccess
                          ? const BorderSide(color: Colors.green)
                          : widget.color != null
                              ? BorderSide(color: widget.color!)
                              : BorderSide(
                                  color: Theme.of(context).primaryColor);
                default:
                  return widget.borders;
              }
            }(),
            primary: () {
              switch (widget.enumButtonType) {
                case EnumButtonType.filledButton:
                  return isErrorOccured
                      ? Colors.red
                      : isSuccess
                          ? Colors.green
                          : widget.color ?? Theme.of(context).primaryColor;
                case EnumButtonType.textButton:
                  return Colors.white;
                case EnumButtonType.outLinedButton:
                  return Colors.white;
                case EnumButtonType.bgOutLinedButton:
                  return isErrorOccured
                      ? Colors.red.withOpacity(0.3)
                      : isSuccess
                          ? Colors.green.withOpacity(0.3)
                          : widget.color != null
                              ? widget.color!.withOpacity(0.3)
                              : Theme.of(context).primaryColor.withOpacity(0.3);
                default:
                  return isErrorOccured
                      ? Colors.red
                      : isSuccess
                          ? Colors.green
                          : widget.color ?? Theme.of(context).primaryColor;
              }
            }(),
            padding: isErrorOccured == true || isSuccess == true
                ? null
                : () {
                    switch (widget.size) {
                      case EnumWidgetSize.lr:
                        return EdgeInsets.only(
                            left: leftPadding(13, 25),
                            right: rightPadding(13, 20));
                      case EnumWidgetSize.md:
                        return EdgeInsets.only(
                            left: leftPadding(13, 25),
                            right: rightPadding(10, 22));
                      case EnumWidgetSize.sm:
                        return EdgeInsets.only(
                            left: leftPadding(13, 20),
                            right: rightPadding(10, 17));
                      default:
                        return EdgeInsets.only(
                            left: leftPadding(13, 25),
                            right: rightPadding(10, 22));
                    }
                  }(),
            shape: () {
              switch (widget.enumButtonType) {
                case EnumButtonType.filledButton:
                  return widget.borderRadius;
                case EnumButtonType.textButton:
                  return null;
                case EnumButtonType.outLinedButton:
                  return widget.borderRadius;
                case EnumButtonType.bgOutLinedButton:
                  return widget.borderRadius;
                default:
                  return widget.borderRadius;
              }
            }()),
      ),
    );
  }

  double leftPadding(double left, double withoutIconPadding) {
    return isPressed == true && isErrorOccured == false && isSuccess == false
        ? withoutIconPadding
        : widget.widgetFrontIcon != null || widget.frontIcon != null
            ? left
            : withoutIconPadding;
  }

  double rightPadding(double right, double withoutIconPadding) {
    return isPressed == true && isErrorOccured == false && isSuccess == false
        ? withoutIconPadding
        : widget.backIcon != null || widget.widgetBackIcon != null
            ? right
            : withoutIconPadding;
  }
}
