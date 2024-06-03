import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/models/update_profile.dart';
import 'package:laborlink/widgets/custom_elevated_button.dart';
import 'package:laborlink/presentation/worker/confirmation_dialog/confirmation_dialog.dart';

// ignore_for_file: must_be_immutable
class SpeciallizationScreen extends StatefulWidget {
  SpeciallizationScreen({Key? key}) : super(key: key);

  @override
  State<SpeciallizationScreen> createState() => _SpeciallizationScreenState();
}

class _SpeciallizationScreenState extends State<SpeciallizationScreen> {
  List<String> professions = [];
  List<String> selectedProfessions = [];
  late List<bool> isChecked =
      List.generate(professions.length, (index) => false);
  @override
  void initState() {
    super.initState();
    loadProfessions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  Future<void> loadProfessions() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('./assets/json_data/data.json');
    final jsonResult = json.decode(data);
    setState(() {
      professions = List<String>.from(jsonResult['professions']);
    });
    print(professions);
  }

  bool designcreative = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 23, top: 13, right: 23, bottom: 13),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: ImageConstant.imgGroup162799,
                          height: getSize(24),
                          width: getSize(24),
                          alignment: Alignment.centerLeft,
                          margin: getMargin(left: 1),
                          onTap: () {
                            onTapImgImage(context);
                          }),
                      Container(
                          width: getHorizontalSize(177),
                          margin: getMargin(top: 44),
                          child: Text("What is your specialization?",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall!
                                  .copyWith(height: 1.33))),
                      Container(
                        height: 400,
                        width: getHorizontalSize(327),
                        margin: getMargin(left: 1, top: 31),
                        padding: getPadding(
                            left: 16, top: 10, right: 16, bottom: 10),
                        decoration: AppDecoration.outlineIndigo.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder24),
                        child: ListView.builder(
                          itemCount: professions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                professions[index].toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Checkbox(
                                onChanged: (value) => setState(() {
                                  isChecked[index] = value!;
                                  if (value) {
                                    selectedProfessions.add(professions[index]);
                                  } else {
                                    selectedProfessions
                                        .remove(professions[index]);
                                  }
                                }),
                                value: isChecked[index],
                                checkColor: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ])),
            bottomNavigationBar: CustomElevatedButton(
                text: "Continue",
                margin: getMargin(left: 24, right: 24, bottom: 39),
                buttonStyle: CustomButtonStyles.fillPrimary,
                onTap: () {
                  onTapContinue(context);
                })));
  }

  /// Displays an [AlertDialog] with a custom content widget using the
  /// provided [BuildContext].
  ///
  /// The custom content is created using the [ConfirmationDialog]
  /// method and is displayed in an [AlertDialog] that fills the entire screen
  /// with no padding.
  onTapContinue(BuildContext context) async {
    print(selectedProfessions);
    UpdateProfile updater =
        UpdateProfile(); // Create an instance of UpdateProfile
    await updater.updateSpecilization(
      context: context,
      specilization: selectedProfessions,
    );
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: ConfirmationDialog(),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgImage(BuildContext context) {
    Navigator.pop(context);
  }

  // getdata(index) {
  //   if (!list.contains(professions[index])) {
  //     list.add(professions[index]);
  //   }
  // }
}
