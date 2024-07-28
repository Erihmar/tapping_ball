import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../custom_widgets/custom_text.dart';
import '../../utils/global.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
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
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
           "Privacy Policy",
          style:TextStyle(fontSize: 30.sp,color: Colors.brown,fontFamily: 'Game')
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.w),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/intro_bg.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 80.h,),
              Padding(
                padding:  EdgeInsets.all(8.w),
                child: Text(Global.policyEn,style: TextStyle(color: Colors.brown,fontWeight: FontWeight.w400,fontSize: 16.sp,fontFamily: 'Game'),),
              )
            ],
          ),
        ),
      )
      ,
    );
  }
}
