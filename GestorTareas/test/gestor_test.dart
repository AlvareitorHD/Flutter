import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas/GestorTareas.dart';
import 'package:gestor_tareas/Tarea.dart';
import 'package:flutter/material.dart';
import 'package:gestor_tareas/main.dart';

void main() {
  group('Pruebas del gestor de tareas', () {

    test('Agregar tareas', () {
      final gestor = GestorTareas();
      final tarea = Tarea('Completar informe');
      final tarea2 = Tarea('Completar practica');

      expect(gestor.agregarTarea(tarea), true);
      expect(gestor.getTareas().length, 1);

      expect(gestor.agregarTarea(tarea2), true);
      expect(gestor.getTareas().length, 2);
    });

    test('Eliminar tarea', () {
      final gestor = GestorTareas();
      final tarea = Tarea('Completar informe');
      gestor.agregarTarea(tarea);

      expect(gestor.eliminarTarea(tarea), true);
      expect(gestor.getTareas().isEmpty, true);

      expect(gestor.eliminarTarea(tarea), false);
    });

    test('Marcar tarea como completada', () {
      final gestor = GestorTareas();
      final tarea = Tarea('Completar informe');
      gestor.agregarTarea(tarea);

      expect(gestor.marcarCompletada(tarea), true);
      expect(tarea.IsCompletada(), true);
    });


  });

  testWidgets('Prueba aplicación Gestor agregando, completando y eliminando tarea', (WidgetTester tester) async {
    // Construir la aplicación y cargar el widget GestorTareasScreen
    await tester.pumpWidget(MaterialApp(home: GestorTareasScreen(title: 'Test')));

    // Asegurarse de que no hay tareas al principio
    expect(find.text('Completada'), findsNothing);

    // Agregar una tarea
    await tester.enterText(find.byType(TextField), 'Hacer la práctica');
    await tester.tap(find.byType(FloatingActionButton));
    // Esperamos a que actualize el estado
    await tester.pump();

    // Verificar que la tarea se agregó correctamente
    expect(find.text('Hacer la práctica'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);

    // Completar la tarea
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verificar que la tarea se completó correctamente
    expect(find.text('Pendiente'), findsNothing);
    expect(find.text('Completada'), findsOneWidget);

    // Eliminar la tarea
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Verificar que la tarea se eliminó correctamente
    expect(find.text('Hacer la práctica'), findsNothing);
  });

}
