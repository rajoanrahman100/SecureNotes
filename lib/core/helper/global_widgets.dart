import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:securenotes/core/constants/app_assets.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({
    Key? key,
  }) : super(key: key);

  //final ChangeLanguageController langC;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2.0,
          ),
        ),
        const Gap(20.0),
        Text("Please wait...", style: bodyMedium16.copyWith(color: AppColors.white),)
      ],
    );
  }
}



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
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
              frameRate: const FrameRate(120),
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
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
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
              frameRate: const FrameRate(120),
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

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final int? maxLength;
  final Function(String)? onChanged;
  final FormFieldSetter<String>? onSave;
  final String? Function(String?)? validation;
  final String? hintTex;
  final TextInputType? inputType;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool? isSuffix;
  final bool? isPrefix;
  final bool? isPrefixWidget;
  final bool? isObsecure;
  final String? labelText;
  final int maxLine;
  final int minLine;
  final bool? isEnable;
  final List<TextInputFormatter>? inputformator;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? enableColor;
  final FocusNode? focusNode;
  final bool? isPassword;
  Iterable<String>? autofill;
  double hPadding;
  double vPadding;
  String? initialVal;
  bool? isTextFieldDense;

  TextFieldWidget(
      {Key? key,
      this.textEditingController,
      this.maxLength,
      this.onChanged,
      this.onSave,
      this.fillColor,
      this.enableColor,
      this.focusNode,
      this.validation,
      this.inputformator,
      this.prefixWidget,
      this.isPassword = false,
      this.hintTex,
      this.inputType,
      this.suffixWidget,
      this.hPadding = 16,
      this.vPadding = 8,
      this.isSuffix = false,
      this.isPrefix = false,
      this.isPrefixWidget = false,
      this.isObsecure = false,
      this.isTextFieldDense = true,
      this.labelText,
      this.maxLine = 1,
      this.minLine = 1,
      this.autofill,
      this.isEnable = true,
      this.textInputAction,
      this.initialVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialVal,
      controller: textEditingController,
      autofocus: false,
      focusNode: focusNode,
      inputFormatters: inputformator,
      textInputAction: textInputAction,
      enabled: isEnable,
      keyboardType: inputType,
      minLines: minLine,
      maxLines: maxLine,
      maxLength: maxLength,
      autofillHints: autofill,
      onChanged: onChanged,
      validator: validation,
      onSaved: onSave,
      obscureText: isObsecure ?? true,
      textCapitalization: isPassword == true ? TextCapitalization.none : TextCapitalization.sentences,
      cursorColor: AppColors.gray400,
      style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', color: AppColors.kBSDark),
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColors.white,
        filled: true,
        isDense: isTextFieldDense == false ? false : true,

        contentPadding: EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: maxLine > 1 ? 15 : vPadding,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableColor ?? AppColors.kBSDark),
          borderRadius: BorderRadius.circular(
            maxLine > 1 ? 10.0 : 10.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(
            context,
            color: enableColor ?? AppColors.kBSDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            maxLine > 1 ? 10 : 10,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: enableColor ?? AppColors.kBSDark),
          borderRadius: BorderRadius.circular(
            maxLine > 1 ? 10 : 10,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error600),
          borderRadius: BorderRadius.circular(
            maxLine > 1 ? 10 : 10,
          ),
        ),
        suffixIcon: isSuffix == true ? suffixWidget : null,
        prefixIcon: isPrefix == true ? prefixWidget : null,
        prefix: isPrefixWidget == true ? prefixWidget : null,
        hintText: hintTex,
        hintStyle: TextStyle(fontSize: 14, fontFamily: 'Poppins', color: AppColors.gray600.withOpacity(0.5)),
      ),
    );
  }
}

class PrimaryButtonWidget extends StatelessWidget {
  PrimaryButtonWidget({
    super.key,
    required this.width,
    this.backColor,
    required this.callback,
    required this.title,
    this.titleColor,
    required this.isLoading,
  });

  final double width;
  Color? backColor;
  final VoidCallback? callback;
  String? title;
  Color? titleColor;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: backColor ?? AppColors.kBSDark,
      height: 48,
      minWidth: width,
      onPressed: callback,
      child: isLoading == true ? const ButtonLoader() : Text("$title",style: bodyMedium16,),
    );
  }
}

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          size: 50,
        ),
      ),
    );
  }
}