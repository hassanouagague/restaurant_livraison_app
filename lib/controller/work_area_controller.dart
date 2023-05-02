import 'dart:async';



import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:food_livraison_app/controller/user_controller.dart';
import 'package:food_livraison_app/model/city.dart';
import 'package:food_livraison_app/model/position_model.dart';
import 'package:food_livraison_app/service/api/user_service.dart';

import '../components/dialoge.dart';
import '../constant/path.dart';
import '../model/date.dart';
import '../model/user_model.dart';
import '../service/api/geolocator_p.dart';
import '../service/api/update_service.dart';
import 'login_controller.dart';
import 'storage_controller.dart';

class WorkAreaController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxDouble zoom = 12.0.obs;
  RxDouble r = 1.0.obs;
  List<DateTime> date = [];
  RxList<City> cities = <City>[].obs;
  RxString dater = "".obs;
  RxString adresse = "".obs;
  Rx<City> city = City(id: "test", nom: "Sélectionné votre ville").obs;
  Completer<GoogleMapController> controllerMap = Completer();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController dateInputAdresse = TextEditingController();
  final UserController userController = Get.put(UserController());
  final LoginController loginController = Get.put(LoginController());
  final StorageController storageController = Get.put(StorageController());
  RxString msg = "".obs;
  RxBool Emsg = true.obs;
  Rx<CameraPosition> kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12.0,
  ).obs;
  RxSet<Circle> circles = <Circle>{}.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  Rx<UserModel> user = UserModel().obs;
  RxString address="address".obs;
  RxString city_name="".obs;
  Future<void> getCities() async {
    cities.value = await UserService().getCities();
    cities.value.add(City(id: "test", nom: "Sélectionné votre ville"));
    if (cities.isNotEmpty) {
      for (var element in cities) {
        if (user.value.villeId == element.id) {
          city.value = element;
        }
      }
    }
    if (user.value.villeId == null) {
      city.value = cities.value.last;
    }
  }


  changeDrop(String? value) {
    for (var element in cities) {
      if (value == element.nom) {
        city.value = element;

      }
    }
  }



  Future sendchangementDispo(BuildContext context) async {
    Dialoge().showLoaderDialog(context);

    msg.value = "";
    Emsg.value = true;

    sleep(const Duration(milliseconds: 200));
    UserModel userGet = await UpdateService().Disponib(user.value, dater.value);
    UserModel userGetinStrg = await UserService().getUser(user.value);
    print("mstfg${userGetinStrg.dates}");
    if (userGet.et! && userGetinStrg.et!) {
      Get.back();
      await storageController.updateData(
          data: userGetinStrg.toJson(), key: "user");
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Mise à jour réussie',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: "problème est survenu lors de l'envoi des données",
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }

  void hasData() {
    if (storageController.hasData(key: "user")) {
      user.value =
          UserModel.fromJsonlocal(storageController.getData(key: "user"));
      userController.isSignIn.value = true;
      update();
    } else {
      userController.isSignIn.value = false;
    }
  }
 late GeocodingPlatform geocoder;
  Future<void> getPositionD(BuildContext context) async {
    Dialoge().showLoaderDialog(context);
    PositionModel positionE = await GeolocatorP().determinePosition();
    if (!positionE.per!) {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: positionE.msg,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      Position currentPostion = positionE.position!;
      lat.value = currentPostion.latitude;
      long.value = currentPostion.longitude;
      LatLng position = LatLng(lat.value, long.value);


      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];

      address = '${place.street} ${place.thoroughfare} ${place.locality} ${place.postalCode} ${place.country}'.obs;
      city_name=place.locality.toString().obs;
      await changePosition(position);
      update();
    }
  }

  Future<void> getPosition() async {
    PositionModel positionE = await GeolocatorP().determinePosition();
    if (!positionE.per!) {

       //lat.value = 59.43296265331129;
       //long.value = -33.08832357078792;
    } else {
      Position currentPostion = positionE.position!;
      lat.value = currentPostion.latitude;
      long.value = currentPostion.longitude;

      update();
    }
  }

  // circles = Set.from([
  //   Circle(
  //        strokeWidth :1,
  //       circleId: CircleId("1"),
  //       center: LatLng(37.42796133580664, -122.085749655962),
  //       radius: 4000,
  //       fillColor: Color.fromARGB(94, 243, 126, 126))
  // ]);
  void setCircles(
      {required String id,
      required double lat,
      required double long,
      required double rayon}) {
    circles.add(Circle(
        strokeWidth: 1,
        circleId: CircleId(id),
        center: LatLng(lat, long),
        radius: rayon ?? 1000,
        fillColor: const Color.fromARGB(94, 243, 126, 126)));
    markers.add(Marker(
      markerId: MarkerId(id),
      position: LatLng(lat, long),
      // icon: BitmapDescriptor.
    ));
  }

  Future<void> changePosition(LatLng arg) async {
    circles.clear();
    markers.clear();
    lat.value = arg.latitude;
    long.value = arg.longitude;
    kGooglePlex.value = CameraPosition(
      target: LatLng(lat.value, long.value),
      zoom: zoom.value,
    );

    setCircles(
      id: userController.user.value.id!,
      long: arg.longitude,
      lat: arg.latitude,
      rayon: r.value * 100,
    );
    final GoogleMapController controllerM = await controllerMap.future;
    await controllerM
        .animateCamera(CameraUpdate.newCameraPosition(kGooglePlex.value));
    update();
  }


  // set position from string address


  Future<void> changePosition_address(LatLng arg) async {
    circles.clear();
    markers.clear();
    lat.value = arg.latitude;
    long.value = arg.longitude;
    kGooglePlex.value = CameraPosition(
      target: LatLng(lat.value, long.value),
      zoom: 15,
    );

    setCircles(
      id: userController.user.value.id!,
      long: arg.longitude,
      lat: arg.latitude,
      rayon: r.value * 100,
    );
    final GoogleMapController controllerM = await controllerMap.future;
    await controllerM
        .animateCamera(CameraUpdate.newCameraPosition(kGooglePlex.value));
    update();
  }




  Future<void> changePositionWhite() async {
    circles.clear();
    markers.clear();
    kGooglePlex.value = CameraPosition(
      target: LatLng(lat.value, long.value),
      zoom: zoom.value,
    );

    setCircles(
      id: userController.user.value.id!,
      long: long.value,
      lat: lat.value,
      rayon: r.value * 100,
    );
    final GoogleMapController controllerM = await controllerMap.future;
    await controllerM
        .animateCamera(CameraUpdate.newCameraPosition(kGooglePlex.value));
    update();
  }

  void getDatefromApi() {
    List<DateDis> dates = user.value.dates!;
    if (dates.isNotEmpty) {
      int i = 1;

      for (DateDis element in dates) {
        if (element.date! != "") {
          date.add(convertStringtoDateTime(element.date!));
          dater.value += element.date!;
          if (dates.length != i) dater.value += ",";
          i++;
        }
      }
    }
    // print(dater.value + "date" + date.toString());

    update();
  }

  @override
  void onInit() async {
    hasData();
    getDatefromApi();
    getCities();
    LatLng? position;
    if (user.value.lat != null) {
      dateInput.text = user.value.rayon ?? r.value.toString();
      dateInputAdresse.text = user.value.adresse ?? "";
      lat.value = double.parse(user.value.lat!);
      long.value = double.parse(user.value.long!);
      r.value = double.parse(user.value.rayon!);
      adresse.value = user.value.adresse ?? "";
      position = LatLng(lat.value, long.value);

    } else {
      await getPosition();
      position = LatLng(lat.value, long.value);
    }

    await changePosition(position);
    super.onInit();
  }

  String convertDateTimetoString(DateTime d) {
    return DateFormat('dd/MM/yyyy').format(d);
  }

  DateTime convertStringtoDateTime(String date) {
    var inputFormat = DateFormat('dd/MM/yyyy');

    var date1 = inputFormat.parse(date);
    var outputFormat = DateFormat('yyyy-MM-dd');
    var date2 = outputFormat.format(date1);
    DateTime parsedDate = DateTime.parse(date2);
    return parsedDate;
  }

  Future<void> sendChangement(context) async {
    if (city.value.id == "test") {
      msg.value = "Sélectionné votre ville ";
      Emsg.value = false;
      return;
    }
    if (lat.value == 0 && long.value == 0) {
      msg.value =
          "problème est survenu lors de la récupération des coordonnées";
      Emsg.value = false;
      return;
    }
    if (r.value == 0) {
      msg.value = "Veuillez remplir la case de rayon";
      Emsg.value = false;
      return;
    }
    if (adresse.value == "") {
      msg.value = "Veuillez remplir la case de adresse ";
      Emsg.value = false;
      return;
    }
    if (adresse.value == "") {
      msg.value = "Veuillez remplir la case de adresse ";
      Emsg.value = false;
      return;
    }

    msg.value = "";
    Emsg.value = true;
    user.value.rayon = r.value.toString();
    user.value.lat = lat.value.toString();
    user.value.long = long.value.toString();
    user.value.adresse = adresse.value;
    user.value.villeId = city.value.id;
    // user.value.villeId =city
    print("---------------------cityId value-------------------------------");
    // print(city.value);
    print("---------------------cityId value-------------------------------");
    updateCart(context);
  }

  void getdate(Object? p) {
    if (p == null) {
      Get.back();
    } else {
      print("objet not null");

      dater.value = "";
      date = p as List<DateTime>;
      int i = 1;
      for (DateTime element in p) {
        dater.value += convertDateTimetoString(element);
        if (date.length != i) dater.value += ",";
        i++;
      }

      Get.back();
    }
  }

  //update adresse
  Future updateCart(context) async {
    Dialoge().showLoaderDialog(context);
    sleep(const Duration(milliseconds: 200));
    UserModel userGet = await UpdateService().addresse(user.value);
    if (userGet.et!) {
      Get.back();
      await storageController.updateData(data: userGet.toJson(), key: "user");
      hasData();
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succès',
        desc: 'Mise à jour réussie',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Erreur',
        desc: userGet.message,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    }
  }
}
