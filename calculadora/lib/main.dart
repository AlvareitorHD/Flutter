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
    setState(() {
      for(int i = 0; i < _impresion.length-1; i++){
        imp += _impresion[i];
      }
      _impresion = imp;
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                '$_impresion',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.cyanAccent, width: 1.0)), // Define una línea de borde inferior
              ),

            ),

          SizedBox(height: 50),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 1; i <= 3; i++)
              ElevatedButton(
                  onPressed: (){aniadirNum(i);},
                  child: Text(i.toString(),style: TextStyle(
                    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                    fontWeight: FontWeight.bold, //negrita
                    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                  ),),
                style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
            ),),
            ElevatedButton(
                onPressed: (){
                  aniadirOp('+');
                },
                child: Text('+',style: TextStyle(
                  fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                  fontWeight: FontWeight.bold, //negrita
                  color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 4; i <= 6; i++)
              ElevatedButton(
                  onPressed: (){aniadirNum(i);},
                  child: Text(i.toString(),style: TextStyle(
                    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                    fontWeight: FontWeight.bold, //negrita
                    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                  ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
                ),),
            ElevatedButton(
                onPressed: (){
                  aniadirOp('-');
                },
                child: Text('-',style: TextStyle(
                  fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                  fontWeight: FontWeight.bold, //negrita
                  color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 7; i <= 9; i++)
              ElevatedButton(
                  onPressed: (){
                    aniadirNum(i);
                    },
                  child: Text(i.toString(),style: TextStyle(
                    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                    fontWeight: FontWeight.bold, //negrita
                    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                  ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
                ),
              ),
            ElevatedButton(
                onPressed: (){
                  aniadirOp('*');
                },
                child: Text('*',style: TextStyle(
                  fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                  fontWeight: FontWeight.bold, //negrita
                  color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: (){
                  aniadirChar('.');
                },
                child: Text('.',style: TextStyle(
                  fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                  fontWeight: FontWeight.bold, //negrita
                  color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
            ElevatedButton(
              onPressed: (){
                aniadirNum(0);
                },
            
              child: Text('0',style: TextStyle(
                fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                fontWeight: FontWeight.bold, //negrita
                color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
              ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Operacion operacion = Suma();
                String n1 = '', n2 = '';
                int i = 0;
                // Extraer el primer número
                if(_impresion[0]=='-'){
                  n1 += _impresion[0];
                  i++;
                }
                while (_impresion[i] != '+' && _impresion[i] != '-' && _impresion[i] != '*' && _impresion[i] != '/' && _impresion[i] != '^') {
                  n1 += _impresion[i];
                  i++;
                }

                // Extraer el operador
                if(_impresion[i] == '+' || _impresion[i] == '-' || _impresion[i] == '*' || _impresion[i] == '/' || _impresion[i] == '^'){
                  if(_impresion[i] != ''){
                    _operacion = _impresion[i];
                  }
                }

                // Extraer el segundo número
                i++; // Pasar al siguiente carácter después del operador
                while (i < _impresion.length) {
                  n2 += _impresion[i];
                  i++;
                }
                //print("Yo: $n1 $_operacion $n2");
                if(n1 != ''){
                  _n1 = double.parse(n1);
                }else{
                  _n1 = 0;
                }
                if(n2 != ''){
                  _n2 = double.parse(n2);
                } else{
                  _n2 = 0;
                }
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
                  _impresion = '';
                  _n1 = 0;
                  _n2 = 0;
                  _resultado_anterior = resultado;
                });
              }, child: Text('=',style: TextStyle(
              fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
              fontWeight: FontWeight.bold, //negrita
              color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
            ),),
    style: ElevatedButton.styleFrom(
    minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
    ),
            ),
            ElevatedButton(
                onPressed: (){
                  aniadirOp('/');
                },
                child: Text('/',style: TextStyle(
                  fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                  fontWeight: FontWeight.bold, //negrita
                  color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
              ),
            ),
          ],
        ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: (){
                    borrarTodo();
                  },
                  child: Text('AC',style: TextStyle(
                    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                    fontWeight: FontWeight.bold, //negrita
                    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                  ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    borrar();
                  },
                  child: Text('<',style: TextStyle(
                    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                    fontWeight: FontWeight.bold, //negrita
                    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                  ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _impresion += _resultado_anterior.toString();
                    });
                  },
                  child: Text('Ans',style: TextStyle(
    fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
    fontWeight: FontWeight.bold, //negrita
    color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
    ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
                ),
              ),

              ElevatedButton(
                  onPressed: (){
                    aniadirOp('^');
                  },
                  child: Text('^',
                    style: TextStyle(
                      fontSize: 30, // Aumenté el tamaño de la fuente para resaltar el resultado
                      fontWeight: FontWeight.bold, //negrita
                      color: Colors.black, // Cambié el color del texto para resaltar el resultado positivo
                    ),
                  ),
    style: ElevatedButton.styleFrom(
    minimumSize: Size(200, 100), // Ajusta el tamaño mínimo del botón
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
