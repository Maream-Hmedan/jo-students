// import 'dart:convert';
// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:jo_student/configuration/constant_values.dart';
// import 'package:jo_student/utils/helpers/general.dart';
//
// import 'user_profile_request.dart';
//
// class UpdateProfileController extends GetxController {
//   // Define observable variables
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;var email = ''.obs;
//   var phone = ''.obs;
//   var name = ''.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     loadInitialProfile();
//   }
//
//   Future<void> loadInitialProfile() async {
//     email.value = await General.getPrefString(ConstantValues.EMAIL, "");
//     phone.value = await General.getPrefString(ConstantValues.PHONE, "");
//     name.value = await General.getPrefString(ConstantValues.NAME, "");
//     print("email.value ${email.value}  phone.value${ phone.value} name.value ${name.value} ");
//   }
//
//   // Method to upload profile
//   Future<void> updateProfile(UpdateProfileRequest request) async {
//     email.value = request.txtemail;
//     phone.value = request.txtphonenumber;
//     name.value = request.txtfullname;
//     // Save updated values
//     await General.savePrefString(ConstantValues.EMAIL,  request.txtemail);
//     await General.savePrefString(ConstantValues.PHONE,  request.txtemail);
//     await General.savePrefString(ConstantValues.PASSWORD,  request.txtemail);
//     try {
//       isLoading.value = true;
//
//       // Prepare the multipart request
//       var uri = Uri.parse('https://jostudents.com/api_website?req=Update_MyProfile');
//       var requestMultipart = http.MultipartRequest('POST', uri);
//       // Add text fields to the request
//       requestMultipart.fields['txtemail'] = request.txtemail;
//       requestMultipart.fields['cmbgender'] = request.cmbgender;
//       requestMultipart.fields['txtfullname'] = request.txtfullname;
//       requestMultipart.fields['cmbcountry'] = request.cmbcountry;
//       requestMultipart.fields['userid'] = request.userid.toString();
//       requestMultipart.fields['txtphonenumber'] = request.txtphonenumber;
//
//       if (request.txtschoolname != null) {
//         requestMultipart.fields['txtschoolname'] = request.txtschoolname!;
//       }
//       if (request.txtaboutme != null) {
//         requestMultipart.fields['txtaboutme'] = request.txtaboutme!;
//       }
//       if (request.txtprofilepic != null) {
//         var profilePic = await http.MultipartFile.fromPath(
//           'txtprofilepic',
//           request.txtprofilepic!,
//         );
//         requestMultipart.files.add(profilePic);
//       }
//
//       // Send the request
//       var response = await requestMultipart.send();
//
//       // Get the response body
//       var responseBody = await response.stream.bytesToString();
//
//       if (response.statusCode == 200) {
//         // Handle successful response
//         Get.snackbar('Success', 'Profile updated successfully');
//       } else {
//         // Handle error response
//         errorMessage.value = 'Failed to update profile';
//         Get.snackbar('Error', errorMessage.value);
//       }
//     } catch (e) {
//       // Handle exceptions
//       errorMessage.value = 'An error occurred: $e';
//       Get.snackbar('Error', errorMessage.value);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:jo_student/configuration/api_end_point.dart';
// import 'package:jo_student/configuration/constant_values.dart';
// import 'package:jo_student/screens/http_wrapper/http_wrapper.dart';
// import 'package:jo_student/utils/helpers/general.dart';
// import 'package:oktoast/oktoast.dart';
// import 'update_settings_request.dart';
// import 'update_settings_response.dart';
//
// class UpdateSettingsController extends GetxController {
//   var isLoading = false.obs;
//   var email = ''.obs;
//   var phone = ''.obs;
//   var password = ''.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     loadInitialSettings();
//   }
//
//   Future<void> loadInitialSettings() async {
//     email.value = await General.getPrefString(ConstantValues.EMAIL, "");
//     phone.value = await General.getPrefString(ConstantValues.PHONE, "");
//     password.value = await General.getPrefString(ConstantValues.PASSWORD, "");
//   }
//
//   Future<void> updateSettings({
//     required String email,
//     required String phone,
//     required String pass,
//   }) async {
//     isLoading.value = true;
//     this.email.value = email;
//     this.phone.value = phone;
//     password.value = pass;
//     // Save updated values
//     await General.savePrefString(ConstantValues.EMAIL, email);
//     await General.savePrefString(ConstantValues.PHONE, phone);
//     await General.savePrefString(ConstantValues.PASSWORD, pass);
//     try {
//       final int? userID = await General.getPrefInt(ConstantValues.ID);
//       final request = UpdateMySettingsRequest(
//         userid: userID ?? -1,
//         txtemailadd: email,
//         txtphonenumber: phone,
//         txtpass: pass,
//       );
//
//       final response = await HttpWrapper(
//         context: Get.context,
//         url: ApiEndPoint.UPDATE_SETTINGS_URL,
//         body: request.toJson(),
//       ).post();
//
//       if (response != null && response.body != null) {
//         final updateMySettingsResponse = UpdateMySettingsResponse.fromRawJson(
//             utf8.decode(response.body!));
//
//         if (response.statusCode == 200 && updateMySettingsResponse.status == 1) {
//
//
//         } else {
//           showToast("Update failed",
//               backgroundColor: Colors.red, duration: const Duration(seconds: 3));
//         }
//       } else {
//         showToast("No response from server",
//             backgroundColor: Colors.red, duration: const Duration(seconds: 3));
//       }
//     } catch (e) {
//       showToast("Error: $e",
//           backgroundColor: Colors.red, duration: const Duration(seconds: 3));
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/configuration/constant_values.dart';
import 'package:jo_students/screens/end_drawer/dashboard_end_drawer/top_profile_dialog/user_profile/user_profile_response.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:jo_students/utils/helpers/general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

import 'user_profile_request.dart';

class UpdateProfileController extends GetxController {

  // Variables to hold the form data
  var email = ''.obs;
  var gender = 0.obs;
  var fullName = ''.obs;
  var schoolName = ''.obs;
  var country = ''.obs;
  var aboutMe = ''.obs;
  var userId = ''.obs;
  var profilePic = Rxn<File>(); // Nullable profile picture
  var phoneNumber = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialProfile();
  }

  void updateImage(XFile? image){
    if(image!= null) {
      profilePic.value=File(image.path);
    }
  }
  Future<void> loadInitialProfile() async {
    email.value = await General.getPrefString(ConstantValues.EMAIL, "");
    phoneNumber.value = await General.getPrefString(ConstantValues.PHONE, "");
    fullName.value = await General.getPrefString(ConstantValues.NAME, "");
    schoolName.value = await General.getPrefString(ConstantValues.SCHOOL_NAME, "");
    aboutMe.value = await General.getPrefString(ConstantValues.ABOUT_ME, "");
  }

  Future<void> updateProfile({
    required String email,
    required int gender,
    required String country,
    required String phone,
    required String name,
    required String userID,
    String? pic,
    String? school,
    String? mine,
  }) async {
    isLoading.value = true;
    this.email.value = email;
    phoneNumber.value = phone;
    this.gender.value = gender;
    fullName.value = name;
    aboutMe.value = mine ?? "";
    schoolName.value=school??"";
    // Save updated values

    await General.savePrefString(ConstantValues.EMAIL, email);
    await General.savePrefString(ConstantValues.NAME, name);
    await General.savePrefString(ConstantValues.PHONE, phone);
    await General.savePrefString(ConstantValues.SCHOOL_NAME, school ?? "");
    await General.savePrefString(ConstantValues.ABOUT_ME, mine ?? "");

    try {
      final int? userID = await General.getPrefInt(ConstantValues.ID);
      final request = UpdateProfileRequest(
        txtphonenumber: phone,
        txtemail: email,
        cmbgender: gender.toString(),
        txtfullname: name,
        txtschoolname: school,
        cmbcountry: country,
        txtaboutme: mine,
        txtprofilepic: pic,
        userid: userID.toString(),
      );

      final response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.UPDATE_PROFILE_URL,
        body: request.toJson()
      ).post();
      if (response != null && response.body != null) {
        final updateMySettingsResponse =
        UpdateProfileResponse.fromRawJson(utf8.decode(response.body!));

        if (response.statusCode == 200 &&
            updateMySettingsResponse.status == 1) {
          showToast("تم حفظ معلوماتك بنجاح",
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3));
        } else {
          showToast("Update failed",
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3));
        }
      } else {
        showToast("No response from server",
            backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      }
    } catch (e) {
      showToast("Error $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }

}
