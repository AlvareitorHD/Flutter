import 'dart:convert';
import 'dart:io';
import 'package:gestor_tareas/Tarea.dart';

class LocalStorage {
  static Future<void> guardarTareas(List<Tarea> tasks) async {
    final file = File('tasks.json');
    final jsonTasks = tasks.map((task) => task.toJson()).toList();
    await file.writeAsString(json.encode(jsonTasks));
  }

  static Future<List<Tarea>> cargarTareas() async {
    try {
      final file = File('tasks.json');
      final jsonString = await file.readAsString();
      final jsonData = json.decode(jsonString) as List<dynamic>;
      return jsonData.map((json) => Tarea.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}