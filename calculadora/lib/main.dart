import 'package:flutter/material.dart';
import 'package:calculadora/Operacion.dart';

// Funcion main que arranca la App
void main() {
  runApp(const Calculadora());
}

// Clase que representa TODA la aplicación
class Calculadora extends StatelessWidget {
  const Calculadora({super.key});

  // Devuelve el widget raíz de toda la aplicacón
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      //QUitar el lazo de DEBUG
      debugShowCheckedModeBanner: false,
      // Widget de inicio (home) con el que empieza
      home: CalculadoraScreen(title: 'Calculadora'),
    );
  }
}

// Clase que representa la UI
class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _operacion = '+';
  double _n1 = 0, _n2 = 0, resultado = 0, _resultado_anterior = 0;
  String _impresion = '';


  void aniadirNum(int n){
    setState(() {
      _impresion += n.toString();
    });
  }
  void aniadirChar(String s){
    setState(() {
      _impresion += s;
    });
  }

  void aniadirOp(String op){
    setState(() {
      _impresion += op;
      _operacion = op;
    });
  }

  void borrarTodo(){
    setState(() {
      _impresion = '';
      _operacion = '+';
      _n1 = 0;
      _n2 = 0;
      resultado = 0;
    });

  }

  void borrar(){
    String imp = '';
    //Si no está vacía la cadena
    if(_impresion.length > 0)
    setState(() {
      for(int i = 0; i < _impresion.length-1; i++){
        imp += _impresion[i];
      }
      _impresion = imp;
    });
  }

  void Operar(){
    Operacion operacion = Suma();
    // Corto las partes de la operación por el tipo de operador
    List<String> partes = _impresion.split(RegExp(r'[-+*/^]'));
    // Extraccion del primer elemento (si no hay -> 0 por defecto)
    _n1 = partes.isNotEmpty?double.parse(partes[0]): 0.0;
   // Asignar operacion (prioridad de orden)
    _operacion = _impresion.contains('^')?'^':
                 _impresion.contains('*')?'*':
                 _impresion.contains('/')?'/':
                 _impresion.contains('+')?'+':
                 _impresion.contains('-')?'-':'';
    //Extraer segundo operando
    _n2 = partes.length > 1? double.parse(partes[1]): 0.0;
    //establecer la operacion a realizar
    switch(_operacion){
      case '+':
        operacion = Suma();
        break;
      case '-':
        operacion = Resta();
        break;
      case '*':
        operacion = Multiplicacion();
        break;
      case'/':
        operacion = Division();
        break;
      case '^':
        operacion = Potencia();
        break;
    }
    setState(() {

      resultado = operacion.calcular(_n1, _n2);
      _impresion = resultado.toString();
      _n1 = 0;
      _n2 = 0;
      _resultado_anterior = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold es la estructura visual de la App
    return Scaffold(
      backgroundColor: Colors.black87,
      // Cabecera de la App
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: TextStyle(color: Colors.red),
        backgroundColor: Colors.cyanAccent,
      ),
      //Cuerpo de la App
      body: Center(
        //Empezamos con Centralizado
        //Hacemos una columna principal
        child: Column(
          //Centralizamos los componentes de la columna
          mainAxisAlignment: MainAxisAlignment.center,
          //Componenetes de la columna:
          children: [
            //Dejar espacio con la cabecera
            SizedBox(height: 20,),
            //Primero: Contenedor con la pantalla
            Container(
              //anchura mínima para la "pantalla de la calculadora"
              constraints: BoxConstraints(minWidth: 1000),
              margin: EdgeInsets.symmetric(horizontal: 20.0), // Márgenes de 20 píxeles a cada lado
              decoration: BoxDecoration(color: Color(0xFF002F00),borderRadius: BorderRadius.circular(10)),

              //Componentes del contenedor (sólo la impresión con estilo)
              child: TextField(
                // Desactivo la capacidad de escribir sobre él
                enabled: false,
                // Pongo el controlador con el texto de impresion
                controller: TextEditingController(text: _impresion),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

          SizedBox(height: 50),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 1; i <= 3; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    aniadirNum(i);
                  },
                  child: Text(
                    " $i ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirOp('+');
                },
                child: Text(
                  " + ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 4; i <= 6; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    aniadirNum(i);
                  },
                  child: Text(
                    " $i ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirOp('-');
                },
                child: Text(
                  " - ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 7; i <= 9; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    aniadirNum(i);
                  },
                  child: Text(
                    " $i ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirOp('*');
                },
                child: Text(
                  " * ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirChar('.');
                },
                child: Text(
                  " . ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirNum(0);
                },
                child: Text(
                  " 0 ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  Operar();
                },
                child: Text(
                  " = ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: () {
                  aniadirOp('/');
                },
                child: Text(
                  " / ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    borrarTodo();
                  },
                  child: Text(
                    " AC ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    borrar();
                  },
                  child: Text(
                    " < ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _impresion += _resultado_anterior.toString();
                    });
                  },
                  child: Text(
                    " Ans ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25, // 5% del ancho de la pantalla
                child: ElevatedButton(
                  onPressed: () {
                    aniadirOp('^');
                  },
                  child: Text(
                    " ^ ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),

            ],
            ),
            SizedBox(height: 40),
            Text(
              'Resultado: $resultado',
              style: TextStyle(
                fontSize: 50, // Aumenté el tamaño de la fuente para resaltar el resultado
                fontWeight: FontWeight.bold, //negrita
                color: Colors.green, // Cambié el color del texto para resaltar el resultado positivo
              ),
            ),

          ],
        ),
      ),
    );
  }
}
