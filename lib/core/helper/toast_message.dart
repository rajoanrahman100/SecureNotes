import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';


//Success Toast Widget
ToastFuture successToast(
    {BuildContext? context,
    String? message,
    StyledToastPosition position = StyledToastPosition.top,
    Color? backColor,
    int durationInSecond = 3}) {
  return showToastWidget(
    Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: AppColors.success600,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            message!,
            style: bodyRegular14.copyWith(color: AppColors.white, fontFamily: AppAssets.poppinsFontFamily),
          )),
          SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset(
              AppAssets.successLottie,
              repeat: false,
              fit: BoxFit.cover,
              frameRate: FrameRate(120),
            ),
          ),
        ],
      ),
    ),
    position: position,
    context: context,
    duration: Duration(
      seconds: durationInSecond,
    ),
  );
}

//Warning Toast Widget
ToastFuture warningToast(
    {BuildContext? context,
    String? message,
    StyledToastPosition position = StyledToastPosition.top,
    Color? backColor,
    int durationInSecond = 6}) {
  return showToastWidget(
    Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: AppColors.error600,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            message!,
            style: bodyRegular14.copyWith(color: AppColors.white, fontFamily: AppAssets.poppinsFontFamily),
          )),
          SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset(
              AppAssets.alertLottie,
              repeat: false,
              fit: BoxFit.cover,
              frameRate: FrameRate(120),
            ),
          ),
        ],
      ),
    ),
    position: position,
    context: context,
    duration: Duration(
      seconds: durationInSecond,
    ),
  );
}
