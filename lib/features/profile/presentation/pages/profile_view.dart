import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/style/app_text_style.dart';
import 'package:cityswitch_app/features/auth/presentation/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

import '../../../add_store/presentation/pages/add_store_view.dart';
import '../../../choose_plan /presentation/pages/pricing_plans_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ProfileViewBody());
  }
}

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Control panel",
              style: AppTextStyle.h1Regular28(
                context,
              ).copyWith(color: AppColors.greenDark),
            ),
            SizedBox(height: 35),

            ProfileDetails(),
            SizedBox(height: 25),
            AddMarket(),
            SizedBox(height: 25),
            ChooseYourPlan(),
            SizedBox(height: 25),
            ProfileDetails(),
          ],
        ),
      ),
    );
  }
}

class AddMarket extends StatelessWidget {
  const AddMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.go(context, AddStoreView.nameRoute);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 16, bottom: 10),

          child: Text(
            'Add Market',
            style: AppTextStyle.h3Regular18(
              context,
            ).copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

/*
class AddMarket extends StatefulWidget {
  @override
  _AddMarketState createState() => _AddMarketState();
}

class _AddMarketState extends State<AddMarket> {
  bool isExpanded = false;
  bool showContent = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: MediaQuery.sizeOf(context).width,
            height: isExpanded ? 790 : 60,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        isExpanded = false;
                        showContent = false;
                      } else {
                        isExpanded = true;
                        Future.delayed(Duration(milliseconds: 900), () {
                          if (mounted) {
                            setState(() {
                              showContent = true;
                            });
                          }
                        });
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 16,
                          bottom: 10,
                        ),

                        child: Text(
                          'Add Market',
                          style: AppTextStyle.h3Regular18(
                            context,
                          ).copyWith(color: AppColors.white),
                        ),
                      ),
                      SizedBox(width: 100),
                      Icon(
                        showContent
                            ? Icons.arrow_downward
                            : Icons.arrow_upward_rounded,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showContent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 0, color: AppColors.greenBright),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Market name"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Address"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Mobile number"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(
                              label: "Market Description",
                              maxLines: 10,
                            ),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Keywords"),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomBtn(
                                  title: "Edit",
                                  onTap: () {},
                                  height: 45,
                                  color: AppColors.blueMid,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                ),
                                CustomBtn(
                                  title: "Save",
                                  onTap: () {},
                                  height: 45,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
class ChooseYourPlan extends StatelessWidget {
  const ChooseYourPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.go(context, ChoosePlan.nameRoute);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 16, bottom: 10),

          child: Text(
            'Choose Your Plan',
            style: AppTextStyle.h3Regular18(
              context,
            ).copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool isExpanded = false;
  bool showContent = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: MediaQuery.sizeOf(context).width,
            height: isExpanded ? 600 : 60,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        isExpanded = false;
                        showContent = false;
                      } else {
                        isExpanded = true;
                        Future.delayed(Duration(milliseconds: 900), () {
                          if (mounted) {
                            setState(() {
                              showContent = true;
                            });
                          }
                        });
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 16,
                          bottom: 10,
                        ),

                        child: Text(
                          'Account Details',
                          style: AppTextStyle.h3Regular18(
                            context,
                          ).copyWith(color: AppColors.white),
                        ),
                      ),
                      SizedBox(width: 100),
                      Icon(
                        showContent
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: showContent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 0, color: AppColors.white),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    "https://th.bing.com/th/id/OIP.xngmei78BNsh21wH8xyj-wHaJ4?rs=1&pid=ImgDetMain",
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Name"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Email"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Phone"),
                            SizedBox(height: 20),
                            CustomTextFieldControlPanel(label: "Adress"),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomBtn(
                                  title: "Edit",
                                  onTap: () {},
                                  height: 45,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                ),
                                CustomBtn(
                                  title: "Save",
                                  onTap: () {},
                                  height: 45,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldControlPanel extends StatefulWidget {
  const CustomTextFieldControlPanel({
    super.key,
    this.initValue,
    this.keyboardType,
    this.isPass = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    // * Decoration
    this.hint,
    this.label,
    this.help,
    this.preIcon,
    this.postIcon,
    this.onTogglePass,
    this.maxLines, // 👈 أضف هذا
  });
  final String? initValue;
  final TextInputType? keyboardType;
  final bool isPass;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  // * Decoration
  final String? hint;
  final String? label;
  final String? help;
  final IconData? preIcon;
  final IconData? postIcon;
  final int? maxLines;
  final VoidCallback? onTogglePass; // 👈 أضف هذا

  @override
  State<CustomTextFieldControlPanel> createState() =>
      _CustomTextFieldControlPanelState();
}

class _CustomTextFieldControlPanelState
    extends State<CustomTextFieldControlPanel> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      focusNode: focusNode,
      initialValue: widget.initValue,
      keyboardType: TextInputType.multiline,
      cursorColor: Colors.green,
      obscureText: widget.isPass,
      obscuringCharacter: '●',
      textCapitalization: TextCapitalization.none,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,

      decoration: InputDecoration(
        filled: true,
        alignLabelWithHint: true, // هذه الخاصية تجعل الـ label ثابت في الأعلى

        fillColor: AppColors.white,
        hintText: widget.hint,
        labelText: widget.label,

        labelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
        border: InputBorder.none,
        helperText: widget.help,
        helperMaxLines: 2,
        prefixIcon:
            widget.preIcon != null
                ? Icon(widget.preIcon, color: Colors.grey)
                : null,
        suffixIcon:
            widget.postIcon != null
                ? IconButton(
                  onPressed:
                      widget
                          .onTogglePass, // 👈 استخدام الدالة القادمة من خارج الودجت
                  icon: Icon(widget.postIcon, color: AppColors.greenBright),
                )
                : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.white, width: 2),
        ),
      ),
    );
  }
}
