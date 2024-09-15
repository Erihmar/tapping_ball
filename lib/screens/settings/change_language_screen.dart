import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/language_controller.dart';
import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../custom_widgets/custom_text.dart';
import '../../languages/enum.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(

        elevation: 0,
        toolbarHeight: 60.h,

        leading: Padding(
          padding:  EdgeInsets.all(10.w),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/left_btn.webp",
                width: 50.w,
                height: 50.h,
              )),
        ),
        leadingWidth: 60.w,
        //iconTheme: const IconThemeData(color: Colors.brown),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CustomText(
          color: primaryColor,
          text: 'change_language'.tr,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left:10.w,right: 10.w,top:kToolbarHeight+ 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("en", "US");
                      },
                      child:  Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                         color: whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/usa.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                   CustomText(
                                    text: "English",
                                    color: primaryColor,
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                    Language.en.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                    Language.en.name
                                    ? secondaryColor
                                    : greyColor,
                              ),
                            ],
                          ),
                      ),
                      ),

                  ),
kSizedBoxH20,
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("zh", "CN");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/china.webp",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                   CustomText(
                                    text: "chinese".tr,
                                    color: primaryColor,
                                     fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                              Icon(
                                languageController.language.value ==
                                    Language.zh.name
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: languageController.language.value ==
                                    Language.zh.name
                                    ? secondaryColor
                                    : greyColor,
                              ),
                            ],
                          ),
                      ),
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
