import 'dart:io';

import 'package:aviation_app/features/pilot_log_book/models/log_book_summary_model/log_book_summary_model.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'log_book_summary_provider.dart';

final logBookDownloadProvider = Provider<LogBookDownloadService>((ref){
  return LogBookDownloadService();
});


class LogBookDownloadService{

  Future<void> downloadLogBook(LogBookSummaryModel logBookSummaryModel) async{
    try{

      PermissionStatus status = await Permission.storage.request();

    // final isGranted = status.isGranted;
     final isGranted = true;
      if(isGranted){
        final Map<String, dynamic> logBookSummaryMap = logBookSummaryModel.toJson();
        List<List<dynamic>> rows = [
          ["Metric", "Value"],
          for (var entry in logBookSummaryMap.entries) [entry.key, entry.value],
        ];
        String csv = const ListToCsvConverter().convert(rows);


        final directory = await getDownloadsDirectory();
        if (directory == null) {
          throw Exception('Downloads directory is not available.');
        }

        final bool isExists = await directory?.exists() ?? false;
        if (!isExists) {
          await directory.create(recursive: true);
        }

        final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
        final path = "${directory.path}/flight_data_$timestamp.csv";
        final file = File(path);


        await file.writeAsString(csv);
        debugPrint("\nPath : $path\n");
        Fluttertoast.showToast(msg: "Download successful. Get it here : ${path}",
            backgroundColor: Colors.green,
            textColor: Colors.white
        );
      }
      else{
debugPrint("\npermission denied\n");
      }

    }catch(error){
      Fluttertoast.showToast(msg: "Download failed.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
      );
      throw Exception('\nFailed to download log book summary\n');
    }
  }
}