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
  double _n1 = 0, _n2 = 0, resultado = 0;
  //final TextEditingController _controllerN1 = Controller();
  final TextEditingController _controllerN2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Scaffold es la estructura visual de la App
    return Scaffold(
      backgroundColor: Colors.black26,
      // Cabecera de la App
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: TextStyle(color: Colors.red),
        backgroundColor: Colors.black12,
      ),
//Cuerpo de la App
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(value: _operacion,
              onChanged: (newValue) {
              setState(() {
                _operacion = newValue.toString();
              });
            },
          items: <String>['+','-','*','/','^'].map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
            ),
            TextField(
              //controller: _controllerN1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Primer número'),
              onChanged: (value){
                setState(() {
                  _n1 = double.parse(value);
                });
              },
            ),
            TextField(
              controller: _controllerN2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Segundo número'),
              onChanged: (value){
                setState(() {
                  _n2 = double.parse(value);
                });
              },
            ),
            ElevatedButton(
                onPressed: (){
                  Operacion operacion = Suma();
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
                  });
                }, child: Text('Calcular'),
            ),
            Text(
              'RESULTADO: $resultado',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
