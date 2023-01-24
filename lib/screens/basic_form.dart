import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/screens/components/petfood_detail_container.dart';

import '../data/category.dart';
import '../data/screen.dart';

class BasicForm extends StatelessWidget {
  BasicForm({super.key});

  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: Stack(
        children: [
          Column(
            children: [
              _header(),
              Obx(
                () => Expanded(
                  child: screen_list[screen_controller.screen_index.value],
                ),
              ),
              _custom_bottom_navigation(),
            ],
          ),
          _speech_bubble(),
          _background(),
          _search_container(),
          Obx(
            () => Visibility(
              visible: screen_controller.petfood_detail_container.value,
              child: PetfoodDetailContainer(),
            ),
          ),
        ],
      ),
    );
  }

  Obx _search_container() {
    return Obx(
      () => Visibility(
        visible: screen_controller.search_container.value,
        child: Positioned(
          left: 50.w,
          top: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.w,
                          height: 30.h,
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10.w)),
                          child: TextFormField(
                            decoration: InputDecoration(border: InputBorder.none, hintText: '검색어를 입력해주세요.'),
                            onChanged: (value) {
                              screen_controller.set_search_text(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      visible: screen_controller.search_text_bool(),
                      child: Container(
                        width: 400.w,
                        height: 200.h,
                        decoration: test_line,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: screen_controller.search_petfood_length.value,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 25.h),
                              child: Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.w),
                                  border: Border.all(color: main_color),
                                ),
                                child: Column(children: [
                                  Image.asset('assets/images/A000001.png'),
                                  Text(screen_controller.search_petfood[index]['name']),
                                ]),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 30.w,
                ),
                onTap: () {
                  screen_controller.set_search_container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _background() {
    return Obx(
      () => Visibility(
        visible: screen_controller.grey_background.value,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Obx _speech_bubble() {
    return Obx(
      () => Visibility(
        visible: screen_controller.show_speech_bubble(),
        child: Stack(
          children: [
            Positioned(
              left: 300.w,
              bottom: 63.h,
              child: Container(
                width: 165.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: mint_color,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                    child: Text(
                  '우리 아이에게 딱 맞는 사료를 찾으려면',
                  style: TextStyle(fontSize: 9.sp),
                )),
              ),
            ),
            Positioned(
              left: 318.w,
              bottom: 55.h,
              child: Image.asset(
                'assets/icons/triangle.png',
                width: 13.w,
                color: mint_color,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _custom_bottom_navigation() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: background_color))),
      child: Row(
        children: [
          _navi_button(index: 0),
          _navi_button(index: 1),
          _navi_button(index: 2),
          _navi_button(index: 3),
          Expanded(
            child: InkWell(
              child: Container(
                height: 63.h,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      right: 20.w,
                      top: 14.h,
                      child: Container(
                        width: 135.w,
                        height: 26.h,
                        decoration: BoxDecoration(color: grey_color, borderRadius: BorderRadius.circular(10.w)),
                      ),
                    ),
                    Positioned(
                      right: 30.w,
                      top: 17.h,
                      child: Image.asset(
                        'assets/icons/magnifying-glass.png',
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                screen_controller.set_search_container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _navi_button({index}) {
    return Obx(
      () => InkWell(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: screen_controller.is_selected_bottom_navi_index(index) ? main_color : Colors.white,
              ),
              width: 96.w,
              height: 63.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    navi_icons[index],
                    width: 18.w,
                    color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    navi_Text[index],
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: index != 2 ? 30.w : 60.w,
              child: Visibility(
                visible: screen_controller.is_selected_bottom_navi_index(index),
                child: Image.asset('assets/icons/triangle.png', width: 13.w),
              ),
            ),
          ],
        ),
        onTap: () {
          screen_controller.set_navi_index(index);
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Column(
            children: [
              //강아지 고양이 버튼
              SizedBox(height: 20.h),
              Image.asset(
                'assets/icons/vertical_logo.png',
                width: 126.w,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  _pet_button(index: 0),
                  _pet_button(index: 1),
                ],
              ),
            ],
          ),
          SizedBox(width: 15.w),
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: Container(
              decoration: test_line,
              width: 420.w,
              height: 83.h,
              child: Center(child: Text('광고')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pet_button({index}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: 62.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: user_controller.is_selected_user_info(text: 'pet', value: index) ? main_color : grey_color,
            borderRadius:
                index == 0 ? BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)) : BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              '${pet_text[index]}',
              style: TextStyle(fontSize: 11.sp, color: user_controller.is_selected_user_info(text: 'pet', value: index) ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () {
          user_controller.set_user_info(text: 'pet', value: index);
        },
      ),
    );
  }
}