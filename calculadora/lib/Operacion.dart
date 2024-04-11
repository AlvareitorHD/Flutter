import 'dart:math' as math;

abstract class Operacion{
  double calcular(double a, double b);
}

class Suma extends Operacion{
  @override
  double calcular(double a, double b) {return a + b;}
}

class Resta extends Operacion{
  @override
  double calcular(double a, double b) {return a - b;}
}

class Multiplicacion extends Operacion{
  @override
  double calcular(double a, double b) {return a * b;}
}

class Division extends Operacion{
  @override
  double calcular(double a, double b) {return a / b;}
}

class Potencia extends Operacion{
  @override
  // Pow() devuelve tipo num (no double), necesario hacer casting toDouble()
  double calcular(double a, double b) { return math.pow(a,b).toDouble();}
}