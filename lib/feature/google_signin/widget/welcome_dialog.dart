import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:securenotes/core/constants/app_colors.dart';
import 'package:securenotes/core/constants/text_styles.dart';
import 'package:securenotes/core/helper/global_widgets.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({super.key, this.userName, this.photoUrl});

  final String? userName;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(20.0),
                CachedNetworkImage(
                  imageUrl: photoUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const ImageErrorWidget(),
                ),
                const Gap(40.0),
                Text("Welcome", style: bodyRegular14.copyWith(color: AppColors.kBSDark)),
                const Gap(5.0),
                Text(
                  "$userName",
                  style: bodySemiBold20.copyWith(color: AppColors.kBSDark),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                const Gap(20.0),
              ],
            ),
            Positioned(
                right: 2.0,
                top: 2.0,
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close, color: AppColors.kBSDark, size: 30.0)))
          ],
        ),
      ),
    );
  }
}
