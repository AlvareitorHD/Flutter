import 'package:calculadora/main.dart';
import 'package:calculadora/Operacion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';



void main(){
group('Pruebas operaciones básicas',(){
  double a = 7;
  double b = 4;
  Operacion op;

  test('Prueba suma',(){
    op = Suma();
    expect(op.calcular(a, b), 11);
    double c = -a;
    expect(op.calcular(c, b), -3);
  });

  test('Prueba resta',(){
    op = Resta();
    expect(op.calcular(a, b), 3);
    double d = -b;
    expect(op.calcular(a, d),11);
  });

  test('Prueba multiplicación',(){
    op = Multiplicacion();
    expect(op.calcular(a, b), 28);
    double c = -a;
    expect(op.calcular(c, b), -28);
    double d = -b;
    expect(op.calcular(c, d), 28);
  });

  test('Prueba división',(){
    op = Division();
    expect(op.calcular(a, b), 1.75);

    //División por 0
    double resultado = op.calcular(a, 0);

      expect(resultado,double.infinity);
  });

  test('Prueba potencia',(){
    op = Potencia();
    expect(op.calcular(a, b), 2401);
  });

});

//Test para simular que un usuario realiza 1 + 2 = 3
testWidgets('Prueba del funcionamiento de los widgets de la Calculadora', (WidgetTester tester) async {
  // Construye la aplicación y desencadena las operaciones de inicio
  await tester.pumpWidget(Calculadora());

  // Encuentra el widget CalculadoraScreen por su clave
  final titleFinder = find.text('Calculadora');
  expect(titleFinder, findsOneWidget); // Verifica que el texto "Calculadora" está presente en la pantalla

  // Encuentra los widgets de botones de la calculadora
  final a = find.text(' 7 ');
  final b = find.text(' 4 ');
  final suma = find.text(' + ');
  final igual = find.text(' = ');

  // Toca los botones en el orden deseado
  await tester.tap(a);
  await tester.tap(suma);
  await tester.tap(b);
  await tester.tap(igual);

  // Espera a que la interfaz de usuario se actualice
  await tester.pump();

  // Verifica que el resultado se muestra correctamente en la pantalla
  final resultFinder = find.text('Resultado: 11.0');
  expect(resultFinder, findsOneWidget);
});
}