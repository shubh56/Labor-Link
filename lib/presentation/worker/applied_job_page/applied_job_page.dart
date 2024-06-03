import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/widgets/custom_elevated_button.dart';

class AppliedJobPage extends StatefulWidget {
  const AppliedJobPage({Key? key}) : super(key: key);

  @override
  AppliedJobPageState createState() => AppliedJobPageState();
}

class AppliedJobPageState extends State<AppliedJobPage>
    with AutomaticKeepAliveClientMixin<AppliedJobPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: getPadding(top: 449),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(top: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: getPadding(left: 24),
                                            child: Text("Job Description",
                                                style: CustomTextStyles
                                                    .titleMediumBluegray900)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width: getHorizontalSize(319),
                                                margin: getMargin(
                                                    left: 31,
                                                    top: 13,
                                                    right: 24),
                                                child: Text(
                                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nec porttitor magna luctus tortor. Pretium malesuada lobortis consequat et mauris. ",
                                                    maxLines: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: CustomTextStyles
                                                        .titleSmallGray600
                                                        .copyWith(
                                                            height: 1.57)))),
                                        Container(
                                            margin: getMargin(bottom: 3),
                                            padding: getPadding(
                                                left: 24,
                                                top: 28,
                                                right: 24,
                                                bottom: 28),
                                            decoration: AppDecoration
                                                .gradientGrayToGray,
                                            child: CustomElevatedButton(
                                                text: "Applied",
                                                margin: getMargin(bottom: 12),
                                                buttonStyle: CustomButtonStyles
                                                    .fillBlueGray,
                                                buttonTextStyle: CustomTextStyles
                                                    .titleMediumBluegray300))
                                      ]))
                            ]))))));
  }
}
