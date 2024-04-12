import 'Tarea.dart';

class GestorTareas{

  late List<Tarea> _tareas;

  GestorTareas(){
    _tareas = [];
  }

  List<Tarea> getTareas(){
    return _tareas;
  }

  bool agregarTarea(Tarea t){
    _tareas.add(t);
    return true;
  }

  bool eliminarTarea(Tarea t){
    if(_tareas.contains(t)){
      _tareas.remove(t);
      return true;
    }
    else{
      return false;
    }
  }

  int getIndiceTarea(Tarea t){
    bool seguir = true;
    int ind = -1;
    for(int i= 0; i < _tareas.length && seguir; i++){
      if(t == _tareas[i]){
        ind = i;
        seguir = false;
      }
    }
    return ind;
  }

  bool marcarCompletada(Tarea t){
    if(_tareas.contains(t)){
      int ind = getIndiceTarea(t);
      _tareas[ind].marcarCompletada();
      return true;
    }
    return false;
  }
}