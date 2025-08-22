import 'dart:io';
import 'package:aviation_app/features/pilot_log_book/models/log_book_summary_model/log_book_summary_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:open_file/open_file.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

final logBookDownloadProvider =
    Provider<LogBookDownloadService>((ref) => LogBookDownloadService());

class LogBookDownloadService {
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) return true;
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  Future<void> downloadLogBookWithProgress({
    required BuildContext context,
    required LogBookSummaryModel logBookSummaryModel,
  }) async {
    try {
      bool granted = await _requestStoragePermission();
      if (!granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Permission denied.")));
        }
        return;
      }

      final Map<String, dynamic> logBookSummaryMap = logBookSummaryModel.toJson();
      
      // Create Excel instance
      final excel = Excel.createExcel();
      
      // Use the default Sheet1 instead of creating a new one
      final sheet = excel['Sheet1'];
      
      // Create headers in first row (each metric becomes a column header)
      List<String> headers = [];
      List<String> values = [];
      
      for (var entry in logBookSummaryMap.entries) {
        headers.add(entry.key);
        values.add(entry.value.toString());
      }
      
      // Add header row (metrics as column headers)
      sheet.appendRow(headers);
      
      // Add values row (values under their respective headers)
      sheet.appendRow(values);

      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        // Alternative path if the above doesn't work
        if (!directory.existsSync()) {
          directory = Directory('/storage/emulated/0/Downloads');
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final path = "${directory.path}/flight_data_$timestamp.xlsx";
      final fileBytes = excel.encode();
      
      if (fileBytes == null) throw Exception('Failed to encode Excel file.');

      final file = File(path);

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => StatefulBuilder(
            builder: (context, setState) {
              int total = fileBytes.length;
              int written = 0;
              double progress = 0.0;

              Future(() async {
                try {
                  final sink = file.openWrite();
                  const int chunkSize = 1024;
                  while (written < total) {
                    final end = (written + chunkSize < total) ? written + chunkSize : total;
                    sink.add(fileBytes.sublist(written, end));
                    written = end;
                    progress = written / total;

                    if (context.mounted) {
                      setState(() {});
                    }
                    await Future.delayed(const Duration(milliseconds: 10));
                  }
                  await sink.close();

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }

                  if (context.mounted) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.download_done),
                                title: const Text('Download Complete'),
                                subtitle: Text('File saved to: $path'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.open_in_new),
                                title: const Text('Open File'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  OpenFile.open(path);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.close),
                                title: const Text('Close'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                } catch (e) {
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error writing file: $e")));
                  }
                }
              });

              return AlertDialog(
                title: const Text("Downloading..."),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 20),
                    Text("${(progress * 100).floor()}%"),
                  ],
                ),
              );
            },
          ),
        );
      }
    } catch (error) {
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Download failed: $error")));
      }
    }
  }

  // Alternative simpler approach - data in columns format
  Future<void> downloadLogBookWithProgressSimple({
    required BuildContext context,
    required LogBookSummaryModel logBookSummaryModel,
  }) async {
    try {
      bool granted = await _requestStoragePermission();
      if (!granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Permission denied.")));
        }
        return;
      }

      final Map<String, dynamic> logBookSummaryMap = logBookSummaryModel.toJson();
      
      // Create Excel instance
      final excel = Excel.createExcel();
      
      // Use the default Sheet1
      final sheet = excel['Sheet1'];
      
      // Create headers and values lists
      List<String> headers = [];
      List<String> values = [];
      
      for (var entry in logBookSummaryMap.entries) {
        headers.add(entry.key);
        values.add(entry.value.toString());
      }
      
      // Add header row (each metric as column header)
      sheet.appendRow(headers);
      
      // Add values row (values under their respective headers)
      sheet.appendRow(values);

      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!directory.existsSync()) {
          directory = Directory('/storage/emulated/0/Downloads');
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final path = "${directory.path}/flight_data_$timestamp.xlsx";
      final fileBytes = excel.encode();
      
      if (fileBytes == null) throw Exception('Failed to encode Excel file.');

      final file = File(path);

      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => StatefulBuilder(
            builder: (context, setState) {
              int total = fileBytes.length;
              int written = 0;
              double progress = 0.0;

              Future(() async {
                try {
                  final sink = file.openWrite();
                  const int chunkSize = 1024;
                  while (written < total) {
                    final end = (written + chunkSize < total) ? written + chunkSize : total;
                    sink.add(fileBytes.sublist(written, end));
                    written = end;
                    progress = written / total;

                    if (context.mounted) {
                      setState(() {});
                    }
                    await Future.delayed(const Duration(milliseconds: 10));
                  }
                  await sink.close();

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }

                  if (context.mounted) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.download_done),
                                title: const Text('Download Complete'),
                                subtitle: Text('File saved to: $path'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.open_in_new),
                                title: const Text('Open File'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  OpenFile.open(path);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.close),
                                title: const Text('Close'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                } catch (e) {
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error writing file: $e")));
                  }
                }
              });

              return AlertDialog(
                title: const Text("Downloading..."),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 20),
                    Text("${(progress * 100).floor()}%"),
                  ],
                ),
              );
            },
          ),
        );
      }
    } catch (error) {
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Download failed: $error")));
      }
    }
  }

  // CSV version with data in columns (headers on first row, values on second row)
  Future<void> downloadLogBookAsCSV({
    required BuildContext context,
    required LogBookSummaryModel logBookSummaryModel,
  }) async {
    try {
      bool granted = await _requestStoragePermission();
      if (!granted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Permission denied.")));
        }
        return;
      }

      final Map<String, dynamic> logBookSummaryMap = logBookSummaryModel.toJson();
      
      // Create CSV content with headers in first row and values in second row
      String headerRow = "";
      String valueRow = "";
      
      // Build header row (metric names)
      List<String> headers = [];
      List<String> values = [];
      
      for (var entry in logBookSummaryMap.entries) {
        headers.add('"${entry.key.replaceAll('"', '""')}"');
        values.add('"${entry.value.toString().replaceAll('"', '""')}"');
      }
      
      headerRow = headers.join(',');
      valueRow = values.join(',');
      
      String csvContent = "$headerRow\n$valueRow\n";

      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!directory.existsSync()) {
          directory = Directory('/storage/emulated/0/Downloads');
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final path = "${directory.path}/flight_data_$timestamp.csv";
      final file = File(path);

      // Write CSV file
      await file.writeAsString(csvContent);

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.download_done),
                    title: const Text('Download Complete'),
                    subtitle: Text('File saved to: $path'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.open_in_new),
                    title: const Text('Open File'),
                    onTap: () {
                      Navigator.of(context).pop();
                      OpenFile.open(path);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.close),
                    title: const Text('Close'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Download failed: $error")));
      }
    }
  }
}