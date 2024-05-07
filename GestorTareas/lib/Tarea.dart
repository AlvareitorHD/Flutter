
class Tarea {

  String _descripcion = '';
  late bool completada;

  Tarea(String descripcion) {
    _descripcion = descripcion;
    completada = false;
  }

  void marcarCompletada(){
    completada = true;
  }

  String getDescripcion(){
    return _descripcion;
  }

  void setDescripcion(String d){
    _descripcion = d;
  }

  bool IsCompletada(){
    return completada;
  }

  // Método para serializar una tarea a formato JSON
  Map<String, dynamic> toJson() {
    return {
      'descripcion': _descripcion,
      'completada': completada,
    };
  }

  // Método estático para deserializar una tarea desde formato JSON
  static Tarea fromJson(Map<String, dynamic> json) {
    return Tarea(
      json['descripcion'] as String,
    )..completada = json['completada'] as bool;
  }
}