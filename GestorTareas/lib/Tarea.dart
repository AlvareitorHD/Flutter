
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
}