// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

// // import 'package:multipart_request/multipart_request.dart';

// class TestKabis extends StatefulWidget {
//   const TestKabis({Key? key}) : super(key: key);

//   @override
//   State<TestKabis> createState() => _TestKabisState();
// }

// class _TestKabisState extends State<TestKabis> {
//   FilePickerResult? result;
//   getFile() async {
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       // allowedExtensions: ['jpg'],
//     );
//     setState(() {
//       result;
//     });
//   }

//   // uploadFile() async {
//   //   var postUri =
//   //       Uri.parse("https://repas-maison.com/MobileAppScript/user.php?type=updatelivreur");
//   //   print(postUri);
//   //   var request = http.MultipartRequest("POST", postUri);
//   //   request.fields['KEY'] =
//   //       '5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg';
//   //   request.fields['part'] = 'kbis';
//   //   request.fields['userID'] = '23';
//   //   request.headers.addAll({
//   //     "Content-Type":
//   //         "multipart/form-data; boundary=<calculated when request is sent>",
//   //   });

//   //   print(result!.paths.first);
//   //   print(result!.names.first);

//   //   request.files
//   //       .add(await http.MultipartFile.fromPath('kbis', result!.paths.first!));

//   //   var response = await request.send();
//   //   if (response.statusCode > 300) print('not Uploaded!');
//   //   if (response.statusCode == 200) print('Uploaded!');
//   //   var resposedata = await response.stream.toBytes();
//   //   var reslt = String.fromCharCodes(resposedata);
//   //   print(reslt);
//   //   // request.;
//   // }
//   Future<bool> updateImage() async {
//     Dio dio = Dio();

//     //  String fileName = file.path.split('/').last;
//     //  dio.options.headers["authorization"] = token;
//     FormData formData = FormData.fromMap({
//       "KEY": "5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg",
//       "part": "kbis",
//       "kbis": await MultipartFile.fromFile(result!.paths.first!),
//       "userID": "23",
//     });
//     try {
//       var response = await dio.post(
//           "https://repas-maison.com/MobileAppScript/user.php?type=updatelivreur",
//           data: formData);

//       if (response.statusCode == 200) {
//       print(response.data)  ;
//         print("uploded");
//         return true;
//       } else {
//         return false;
//       }
//     } catch (r) {
//       return false;
//     }
//   }
//   //  void sendRequest(imagePath) {
//   //     var request = MultipartRequest();
//   //     request
//   //         .setUrl("https://repas-maison.com/MobileAppScript/user.php?type=updatelivreur");
//   //     request.addField(
//   //         "KEY", '5u93m7q8h44kgss4gkw8gcwosso4s44cs0c8wkw0s4g08k08kg');
//   //     request.addField("part", 'kbis');
//   //     request.addField("userID", '23');

//   //     request.addFile("kbis", imagePath);

//   //     Response response = request.send();

//   //     response.onError = () {
//   //       print("Error");
//   //     };

//   //     response.onComplete = (response) {
//   //       print(response);
//   //     };

//   //     response.progress.listen((int progress) {
//   //       print("progress from response object " + progress.toString());
//   //     });
//   //   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   await getFile();
//                 },
//                 child: Text("UPlode")),
//             ElevatedButton(
//                 onPressed: () async {
//                   // sendRequest(result!.files.first.path);
//                   await updateImage();
//                 },
//                 child: Text("UP")),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Future<Stream<User>> register(User user) async {
// //   try {
// //     String url = '$baseApiUrl/register';
// //     final client = http.Client();
// //     http.MultipartRequest request =
// //         http.MultipartRequest('POST', Uri.parse(url));
// //     if (user.checkHasMedia) {
// //       request.files
// //           .add(await http.MultipartFile.fromPath('image', user.image!));
// //     }
// //     request.headers.addAll(Helper.customHeader());
// //     request.fields.addAll(user.registerToJson());
// //     final response = await client.send(request);
// //     if (response.statusCode == 200) {
// //       return response.stream
// //           .transform(utf8.decoder)
// //           .transform(json.decoder)
// //           .map((data) => Helper.getData(data))
// //           .map((data) => User.fromJson(data));
// //     }
// //   } catch (e) {}
// // }
