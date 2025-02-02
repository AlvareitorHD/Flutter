import 'package:flutter/material.dart';
import 'package:gestor_tareas/GestorTareas.dart';
import 'package:gestor_tareas/Tarea.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de tareas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const GestorTareasScreen(title: 'Gestor de Tareas'),
    );
  }
}

class GestorTareasScreen extends StatefulWidget {
  const GestorTareasScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<GestorTareasScreen> createState() => _GestorTareasScreen();
}

class _GestorTareasScreen extends State<GestorTareasScreen> {

  final GestorTareas gestor = GestorTareas();
  final TextEditingController _controller = TextEditingController();
  String _descripcion = '';

  void aniadirTarea() {
    if(_descripcion != '')
    setState(() {
      gestor.agregarTarea(Tarea(_descripcion));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nueva Tarea",
                    ),
                    controller: _controller,
                    onChanged: (value) {
                      _descripcion = value;
                    },
                  ),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    aniadirTarea();
                    //Limpiamos el TextField tras añadir la tarea
                    _controller.clear();
                    _descripcion = '';
                  },
                  tooltip: 'Añadir tarea',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Con Expanded ocupo el espacio disponible de la pantalla
            Expanded(
              // Agrego relleno horizontal de 40 px
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                // Construyo lista que añade tareas dinámicamente
                child: ListView.builder(
                  // cantidad de tareas de la lista
                  itemCount: gestor.getTareas().length,
                  // a través de un índice devuelve un widget tarea
                  itemBuilder: (context, index) {
                    Tarea tarea = gestor.getTareas()[index];
                    return Padding(
                      // Espacio entre tareas verticalmente
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      // Widget para hacer de contenedor de cada tarea
                      child: Card(
                        // efecto sombra paralela
                        elevation: 4.0,
                        // widget que representa una tarea
                        child: ListTile(
                          // DESCRIPCION
                          title: Text(
                            tarea.getDescripcion(),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          // ESTADO DE LA TAREA
                          subtitle: Text(
                            tarea.IsCompletada()?"Completada":"Pendiente",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !tarea.completada?Colors.grey:Colors.green,
                            ),
                          ),
                          // CASILLA DE COMPLETADA
                          leading: Checkbox(
                            value: tarea.completada,
                            onChanged:(value){
                              setState(() {
                                tarea.completada = !tarea.completada;
                              });
                            }
                          ),
                          // al final del ListTile poner el BOTON ELIMINAR TAREA
                          trailing: IconButton(
                          icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                gestor.eliminarTarea(tarea);
                              });
                          },),
                      ),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

