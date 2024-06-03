import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/widgets/custom_elevated_button.dart';
import 'package:laborlink/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: getPadding(
          all: 16,
        ),
        decoration: AppDecoration.outlineIndigo.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconButton(
                  height: getSize(48),
                  width: getSize(48),
                  padding: getPadding(
                    all: 8,
                  ),
                  child: CustomImageView(
                    svgPath: ImageConstant.imgGroupPrimary,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 12,
                    top: 4,
                    bottom: 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Plumbing",
                        style: CustomTextStyles.titleMediumBold_1,
                      ),
                      Padding(
                        padding: getPadding(
                          top: 5,
                        ),
                        child: Text(
                          "John Smith",
                          style: CustomTextStyles.labelLargeBluegray300SemiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  svgPath: ImageConstant.imgBookmark,
                  height: getSize(24),
                  width: getSize(24),
                  margin: getMargin(
                    bottom: 25,
                  ),
                ),
              ],
            ),
            Padding(
              padding: getPadding(
                left: 60,
                top: 9,
              ),
              child: Text(
                "250 Rupees",
                style: CustomTextStyles.labelLargeGray600_1,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: getPadding(
                  top: 13,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      height: getVerticalSize(28),
                      width: getHorizontalSize(70),
                      text: "One day",
                      buttonTextStyle: theme.textTheme.labelLarge!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
