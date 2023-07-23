import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ConsumableStore {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/consumables.json');
  }

  static Future<List<String>> load() async {
    try {
      final file = await _localFile;
      if (file.existsSync()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = json.decode(contents);
        final List<String> consumables =
            jsonList.map((dynamic json) => json.toString()).toList();
        return consumables;
      }
    } catch (e) {
      // Error reading file.
    }
    return <String>[];
  }

  static Future<void> save(String id) async {
    try {
      final file = await _localFile;
      final List<String> consumables = await load();
      consumables.add(id);
      final jsonString = json.encode(consumables);
      await file.writeAsString(jsonString);
    } catch (e) {
      // Error writing to file.
    }
  }

  static Future<void> consume(String id) async {
    try {
      final file = await _localFile;
      final List<String> consumables = await load();
      consumables.remove(id);
      final jsonString = json.encode(consumables);
      await file.writeAsString(jsonString);
    } catch (e) {
      // Error writing to file.
    }
  }
}
