import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kiosk_v4/components/basic_function.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/data/detail_petfood.dart';

class PetfoodDetailContainer extends StatelessWidget {
  PetfoodDetailContainer({super.key});
  var screen_controller = Get.put(ScreenController());
  var price = NumberFormat('###,###,###,###');
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        left: 50.w,
        top: 5.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
              width: 500.w,
              height: 450.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.w),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  _header_info(),
                  SizedBox(height: 10.h),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animated_velocity),
                    height: 320.h,
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: background_blue_color, width: 1.w))),
                    child: InteractiveViewer(
                      child: SingleChildScrollView(
                        controller: screen_controller.scroll_controller.value,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20.w, top: 25.h),
                              width: 440.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.w),
                                color: background_blue_color,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _main_info_1(),
                                  SizedBox(height: 15.h),
                                  _main_info2(),
                                  SizedBox(height: 30.h),
                                  _detail_info(),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: 30.h),
                                _rotation_feed_container(),
                                SizedBox(height: 30.h),
                                _rotation_days_container(),
                                SizedBox(height: 30.h),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('??? ??????', style: TextStyle(fontSize: 12.sp)),
                                      Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 20.w,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    screen_controller.scroll_up();
                                  },
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text('????????? ??????', style: TextStyle(fontSize: 11.sp)),
                  //       Icon(Icons.keyboard_arrow_down, size: 20.w),
                  //     ],
                  //   ),
                  //   onTap: () {

                  //   },
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 45.h),
              child: InkWell(
                child: Icon(Icons.cancel, size: 30.w),
                onTap: () {
                  screen_controller.set_petfood_detail_container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Obx _detail_info() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/petfood_border.png', width: 30.w),
              SizedBox(width: 6.w),
              Text('?????? ??? ?????????!', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.h),
          for (var index = 0; index < screen_controller.petfood_detail_data['title'].length; index++) _contents_explain(index),
          Row(
            children: [
              Image.asset('assets/icons/nutrients.png', width: 30.w),
              SizedBox(width: 6.w),
              Text('????????????', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.h),
          Text('?????????', style: TextStyle(fontSize: 15.sp, color: main_color)),
          SizedBox(height: 5.h),
          Container(
            width: 400.w,
            child: Text(
              screen_controller.petfood_detail_data['all_ingredient'],
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
          SizedBox(height: 20.h),
          Text('????????????', style: TextStyle(fontSize: 15.sp, color: main_color)),
          _nutrients_table(),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Column _rotation_days_container() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('?????? ?????? ?????? ??????', style: TextStyle(fontSize: 12.sp, color: main_color)),
            SizedBox(width: 10.w),
            Container(width: 330.w, height: 1.h, color: Colors.black),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: 440.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _petfood_caution_column(img: 'assets/icons/petfood_25.png', text: '      1-3???'),
              _petfood_caution_column(img: 'assets/icons/petfood_50.png', text: '      4-6???'),
              _petfood_caution_column(img: 'assets/icons/petfood_75.png', text: '      7-10???'),
              _petfood_caution_column(img: 'assets/icons/petfood_100.png', text: '      10??? ??????'),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: 440.w,
          child: Center(
            child: Text(
              '?????? ????????? ??? 7-10??? ?????? ?????? ?????? ????????? ???????????????.',
              style: TextStyle(fontSize: 12.sp, color: color_128),
            ),
          ),
        ),
      ],
    );
  }

  Container _rotation_feed_container() {
    return Container(
      width: 440.w,
      decoration: BoxDecoration(border: Border.all(color: main_color), borderRadius: BorderRadius.circular(5.w)),
      child: Column(
        children: [
          Container(
            height: 30.h,
            color: background_blue_color,
            child: Center(
              child: Text('????????????', style: TextStyle(fontSize: 14.sp, color: main_color)),
            ),
          ),
          Container(
            width: 400.w,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.w))),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Text(
                  '?????? ?????? ????????? ?????? ????????? ???????????? ???????????? ???????????????. ?????????\n?????????????????? ????????? ???????????? ???????????? ????????? ????????? ??? ????????????.',
                  style: TextStyle(fontSize: 12.sp, color: color_128),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Image.asset('assets/icons/rotation_feed.png', width: 250.w),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _petfood_caution_column({img, text}) {
    return Column(
      children: [
        Image.asset(img, width: 63.w),
        SizedBox(height: 5.h),
        Text(text, style: TextStyle(fontSize: 12.sp, color: color_128)),
      ],
    );
  }

  Widget _nutrients_table() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      width: 380.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '(??????: %)',
            style: TextStyle(fontSize: 10.sp),
          ),
          Table(
            border: TableBorder(horizontalInside: BorderSide(width: 1.w, color: grey_color)),
            children: [
              TableRow(
                children: [
                  Container(height: 40.h, color: Colors.white, child: Center(child: Text('??????', style: TextStyle(fontSize: 12.sp)))),
                  for (var index = 0; index < nutrients_kor.length - 1; index++)
                    Container(height: 40.h, color: Colors.white, child: Center(child: Text(nutrients_kor[index], style: TextStyle(fontSize: 12.sp)))),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    height: 40.h,
                    color: Colors.white,
                    child: Center(
                      child: Text('??????\n????????????', style: TextStyle(fontSize: 12.sp), textAlign: TextAlign.center),
                    ),
                  ),
                  for (var index = 0; index < nutrients_text.length; index++)
                    Container(
                        height: 40.h,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "${screen_controller.petfood_detail_data[nutrients_text[index]]}",
                            style: TextStyle(color: main_color, fontSize: 12.sp),
                          ),
                        )),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    height: 40.h,
                    color: grey_color,
                    child: Center(child: Text('??????\n????????????', style: TextStyle(fontSize: 12.sp), textAlign: TextAlign.center)),
                  ),
                  for (var index = 0; index < nutrients_text.length; index++)
                    Container(
                        height: 40.h,
                        color: grey_color,
                        child: Center(
                          child: Text(
                            "${screen_controller.petfood_detail_data[nutrients_text[index] + '_dm']}",
                            style: TextStyle(color: main_color, fontSize: 12.sp),
                          ),
                        )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contents_explain(int index) {
    return Container(
      height: 90.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 5.w),
          Text(
            '${index + 1}',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: main_color),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text(
                screen_controller.petfood_detail_data['title'][index],
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: main_color),
              ),
              SizedBox(height: 3.h),
              Container(
                width: 360.w,
                child: Text(screen_controller.petfood_detail_data['content'][index], style: TextStyle(fontSize: 11.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _main_info2() {
    return Row(
      children: [
        Container(
          width: 90.w,
          height: 50.h,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, size: 35.w),
              SizedBox(width: 10.w),
              Text(screen_controller.petfood_detail_data['kibble'].toString() + 'mm', style: TextStyle(fontSize: 11.sp)),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('(%)', style: TextStyle(fontSize: 8.sp)),
            SizedBox(height: 2.h),
            Container(
              width: 285.w,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      for (var nutrients_index = 0; nutrients_index < 6; nutrients_index++)
                        Container(
                          color: main_color,
                          height: 25.h,
                          child: Center(
                            child: Text(nutrients_kor[nutrients_index], style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                          ),
                        ),
                    ],
                  ),
                  TableRow(
                    children: [
                      for (var nutrients_index = 0; nutrients_index < 5; nutrients_index++)
                        Container(
                          color: Colors.white,
                          height: 25.h,
                          child: Center(
                            child: Text(
                              "${screen_controller.petfood_detail_data[nutrients_text[nutrients_index] + '_dm']}",
                              style: TextStyle(color: main_color, fontSize: 10.sp),
                            ),
                          ),
                        ),
                      Container(
                        color: Colors.white,
                        height: 25.h,
                        child: Center(
                          child: Text((screen_controller.petfood_detail_data['kcal'] * 10).toInt().toString(), style: TextStyle(color: main_color, fontSize: 10.sp)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Text('*DM ?????? /kg ??????', style: TextStyle(fontSize: 8.sp)),
          ],
        ),
      ],
    );
  }

  Row _main_info_1() {
    return Row(
      children: [
        Container(
          height: 68.h,
          decoration: test_line,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var hash_index = 0; hash_index < screen_controller.petfood_detail_data['hash'].length; hash_index++)
                Container(
                  width: 90.w,
                  child: Text('#  ' + screen_controller.petfood_detail_data['hash'][hash_index], style: TextStyle(fontSize: 11.sp, color: main_color)),
                ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        _main_info_container(title: '????????????', info: screen_controller.set_life_stage_text()),
        SizedBox(width: 5.w),
        _main_info_container(title: '???????????????', info: user_controller.user_info['pet'].value == 0 ? screen_controller.set_size_text() : '??????'),
        SizedBox(width: 5.w),
        _main_info_container(title: '????????????', info: list_to_str(screen_controller.petfood_detail_data['shape'])),
        SizedBox(width: 5.w),
        _main_info_container(title: '??? ????????????', info: screen_controller.set_main_ingredient()),
      ],
    );
  }

  Container _main_info_container({title, info}) {
    return Container(
      width: 68.w,
      height: 70.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Colors.white),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Image.asset('assets/icons/check.png', width: 10.w),
          SizedBox(height: 4.h),
          Text('${title}', style: TextStyle(fontSize: 11.sp, color: Color.fromRGBO(128, 128, 128, 1))),
          Text('${info}', style: TextStyle(fontSize: 12.sp), overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }

  Row _header_info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 95.w,
              height: 95.h,
              child: Image.asset(
                'assets/images/' + screen_controller.petfood_detail_data['eng_name'] + '.png',
                width: 95.w,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.only(bottom: 5.h),
              height: 95.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(screen_controller.petfood_detail_data['brand'], style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color.fromRGBO(150, 151, 153, 1))),
                      Text(screen_controller.petfood_detail_data['short_name'], style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: main_color)),
                    ],
                  ),
                  Text('${screen_controller.petfood_detail_data['weight']} | ${price.format(screen_controller.petfood_detail_data['retail_price'])}???', style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/qr/' + screen_controller.petfood_detail_data['eng_name'] + '.png',
              width: 50.w,
            ),
            Text(
              '????????????\n????????????',
              style: TextStyle(fontSize: 9.sp, color: color_128),
            ),
          ],
        ),
      ],
    );
  }
}
