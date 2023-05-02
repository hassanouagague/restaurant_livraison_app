import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_livraison_app/components/input/constom_input.dart';
import 'package:food_livraison_app/controller/work_area_controller.dart';
import 'package:food_livraison_app/model/city.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_text_style.dart';

class WorkArea extends StatelessWidget {

  WorkArea({Key? key}) : super(key: key);
  final WorkAreaController controller = Get.put(WorkAreaController());
  final GlobalKey<FormState> _workArea = GlobalKey<FormState>();
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  double area_rayon=0;
  String city_name='';
  String address_typed='';
  String address_='1600 Amphitheatre Parkway, Mountain View, CA';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Adresse Et Disponibilité"),
          backgroundColor: ThemeColors.primary,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _workArea,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Adresse Et Disponibilité",
                        style: ThemeTextStyle().headingOne,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Text("Adresse De Travaille",
                          style: ThemeTextStyle().body),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(

                        children: [
                          ConstomInputRest(
                            title: "ADRESSE",
                            controller: controller.dateInputAdresse,
                            //value: controller.address.toString()!="" ?? controller.address.toString() : "address",
                            onChanged: (String? val) async{

                                controller.adresse.value = val!;
                                address_typed=val.toString()!;

                                /*
                              var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=$address_typed&key=AIzaSyDPUkxP3fEgwO8zudfv8b0SLlPyqgkSksE");
                              var response = await http.get(url);
                              if(response.statusCode==200){
                                var decodedResponse = json.decode(response.body);
                                var lat = decodedResponse["results"][0]["geometry"]["location"]["lat"];
                                var lng = decodedResponse["results"][0]["geometry"]["location"]["lng"];
                                LatLng searchedLocation = LatLng(lat, lng);
                                controller.changePosition_address(searchedLocation);
                                print('hello new lat >>'+lat);
                                print('hello new long >>'+lng);
                                */

                              //}
                              //else{
                               // print('maps error');
                              //}
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                'Ville',
                                style: ThemeTextStyle().label,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            height: 40.h,
                            child: Obx(() {
                              if (controller.cities.isEmpty) {
                                return const SizedBox();
                              }
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isDense: true,
                                    // Initial Value
                                    // value: controller.city.value ?? "",
                                    isExpanded: true,
                                    value: controller.city.value.nom,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items:
                                        controller.cities.value.map((City items) {
                                      return DropdownMenuItem(
                                        value: items.nom,
                                        child: Text(items.nom!),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) async {
                                      city_name=value!;

                                      print('hello this the selected city >>>>'+city_name);
                                      controller.changeDrop(value);

                                      // get location

                                      var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=$city_name&key=AIzaSyDPUkxP3fEgwO8zudfv8b0SLlPyqgkSksE");

                                      var response = await http.get(url);
                                      if(response.statusCode==200){
                                        var decodedResponse = json.decode(response.body);
                                        var lat = decodedResponse["results"][0]["geometry"]["location"]["lat"];
                                        var lng = decodedResponse["results"][0]["geometry"]["location"]["lng"];
                                        LatLng searchedLocation = LatLng(lat, lng);
                                        controller.changePosition_address(searchedLocation);
                                        print('hello new lat >>'+lat);
                                        print('hello new long >>'+lng);
                                      }
                                      else{
                                        print('maps error');
                                      }

                                    },
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ConstomInput(
                              title: "rayon (Km)",
                              controller: controller.dateInput,
                              onChanged: (String? val) async {
                                if (isNumeric(val!)) {
                                  controller.r.value = double.parse(val);
                                  area_rayon=double.parse(val);
                                  print('hello new area >>'+area_rayon.toString());
                                  print('hello new address >>'+address_typed.toString());
                                  print('hello this the selected city >>>>'+city_name);
                                  await controller.changePositionWhite();
                                } else {}
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () async{
                                //String address = "1600 Amphitheatre Parkway, Mountain View, CA";



                                //print('hello new area >>'+area_rayon.toString());

                                controller.getPositionD(context);
                               // print("hello new generated address"+controller.address.toString());

                              },
                              icon: const Icon(Icons.my_location))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(() {
                        if (controller.long.value == 0 &&
                            controller.lat.value == 0)
                        {
                          return SizedBox(
                            height: 400.h,
                            width: double.infinity,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 400.h,
                          width: double.infinity,
                          child: GoogleMap(
                            onTap: (LatLng argument) {
                              controller.changePosition(argument);
                            },
                            onCameraMove: (CameraPosition position) {
                              controller.zoom.value = position.zoom;
                            },
                            markers: controller.markers.value,
                            circles: controller.circles.value,
                            mapType: MapType.normal,
                            initialCameraPosition: controller.kGooglePlex.value,
                            onMapCreated: (GoogleMapController controllerr) {
                              controller.controllerMap.complete(controllerr);
                            },
                          ),
                        );
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("Dates De l'Indisponibilités",
                          style: ThemeTextStyle().body),
                      Obx(() {
                        return Container(
                            padding: EdgeInsets.all(15.h),
                            height: 70.h,
                            child: Center(
                                child: TextField(
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: const Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: controller.dater.value == ""
                                      ? "Entrer La Date " //label text of field
                                      : controller.dater.value),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                            padding: EdgeInsets.all(15),
                                            // height: MediaQuery.of(context).size.width / 3,
                                            child: SfDateRangePicker(
                                              cancelText: "Annuler",
                                              controller:
                                                  _dateRangePickerController,
                                              initialSelectedDates:
                                                  controller.date,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .multiple,
                                              showActionButtons: true,
                                              onCancel: () {
                                                _dateRangePickerController
                                                    .selectedDates = null;
                                                controller.date = [];
                                                controller.dater.value = "";
                                                Get.back();
                                              },
                                              onSubmit: (p0) {
                                                controller.getdate(p0);
                                              },
                                            )),
                                      );
                                    });
                              },
                            )));
                      }),
                      Obx(() {
                        return Visibility(
                          visible: !controller.Emsg.value,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.msg.value,
                                    style: ThemeTextStyle().error,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.r), // <-- Radius
                                    ),
                                    primary: ThemeColors.primary,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10.h)),
                                onPressed: () async {
                                  await controller.sendChangement(context);
                                },
                                child: const Text('Changer Adresse')),
                          ),
                          SizedBox(
                            width: 8.h,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.r), // <-- Radius
                                    ),
                                    primary: ThemeColors.primary,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10.h)),
                                onPressed: () async {
                                  controller.sendchangementDispo(context);
                                },
                                child: const Text('Changer La Date')),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
