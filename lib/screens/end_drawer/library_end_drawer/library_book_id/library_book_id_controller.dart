import 'dart:convert';

import 'package:jo_students/configuration/api_end_point.dart';
import 'package:jo_students/screens/http_wrapper/http_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'library_boob_id_response.dart';
import 'library_book_id_request.dart';




enum ApiStatus { loading, empty, error, success }

class LibraryGetDetailsController extends GetxController {
  var bookImage = "".obs;
  var bookDesc = "".obs;
  var bookWriter = "".obs;
  var bookPage = "".obs;
  var bookDate = "".obs;
  var bookPdf = "".obs;
  var bookTitle = "".obs;
  var showBookDetails = false.obs;

  var status = ApiStatus.loading.obs;


  fetchLibraryBooksDetailsFromApi({required int libraryBookID}) async {

    try {
      LibraryBookIdRequest request = LibraryBookIdRequest(
          libraryBookId: libraryBookID
         );
      ApiResponse? response = await HttpWrapper(
        context: Get.context,
        url: ApiEndPoint.LIBRARY_ID_URL,
        body: request.toJson(),
      ).post();
      if (response!.statusCode == 200) {
        if (response.body != null) {
          LibraryBookIdResponse libraryBookIdResponse =
          LibraryBookIdResponse.fromRawJson(utf8.decode(response.body!));
          status.value = ApiStatus.success;
          if(showBookDetails.value==false){
            showBookDetails.value = !showBookDetails.value;
            bookTitle.value=libraryBookIdResponse.libraryBookTitle;
            bookDate.value=libraryBookIdResponse.libraryBookDt;
            bookWriter.value=libraryBookIdResponse.libraryBookAuthor;
            bookImage.value= libraryBookIdResponse.libraryBookThumpnailMobile;
            bookDesc.value=libraryBookIdResponse.libraryBookDesc;
            bookPdf.value=libraryBookIdResponse.libraryBookPdfFileMobile;
            bookPage.value=libraryBookIdResponse.libraryBookPagesNo;
          }else{
            bookTitle.value=libraryBookIdResponse.libraryBookTitle;
            bookWriter.value=libraryBookIdResponse.libraryBookAuthor;
            bookImage.value= libraryBookIdResponse.libraryBookThumpnailMobile;
            bookDesc.value=libraryBookIdResponse.libraryBookDesc;
            bookPdf.value=libraryBookIdResponse.libraryBookPdfFileMobile;
            bookPage.value=libraryBookIdResponse.libraryBookPagesNo;
          }

        } else {
          status.value = ApiStatus.empty;
          Get.snackbar('Error', 'An error occurred while fetching book details');
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      showToast("Something went wrong while fetching library book details: $e",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
    }
  }



  bool get isLoading => status.value == ApiStatus.loading;

  bool get isEmpty => status.value == ApiStatus.empty;

  bool get isError => status.value == ApiStatus.error;

  bool get isSuccess => status.value == ApiStatus.success;
}
