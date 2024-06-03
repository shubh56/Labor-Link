import '../saved_page/widgets/saved_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/widgets/app_bar/appbar_image.dart';
import 'package:laborlink/widgets/app_bar/appbar_title.dart';
import 'package:laborlink/widgets/app_bar/custom_app_bar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            appBar: CustomAppBar(
                leadingWidth: getHorizontalSize(48),
                leading: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 13),
                    onTap: () {
                      onTapArrowbackone(context);
                    }),
                centerTitle: true,
                title: AppbarTitle(text: "Saved")),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, right: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: getPadding(top: 30),
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                        height: getVerticalSize(12));
                                  },
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return SavedItemWidget();
                                  }))),
                    ]))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowbackone(BuildContext context) {
    Navigator.pop(context);
  }
}
