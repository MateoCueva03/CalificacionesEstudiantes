import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  while (true) {
    print("1. Agregar estudiante");
    print("2. Calcular promedio de estudiante");
    print("3. Calificaciones más alta y más baja por asignatura");
    print("4. Estudiantes con promedio superior");
    print("5. Ordenar estudiantes por promedio");
    print("6. Salir");
    int opcion = int.parse(stdin.readLineSync()!);
    switch (opcion) {
      case 1:
        agregarEstudiante();
        break;
      case 2:
        calcularPromedioEstudiante();
        break;
      case 3:
        calificacionesMasAltaYMasBaja();
        break;
      case 4:
        estudiantesConPromedioSuperior();
        break;
      case 5:
        ordenarEstudiantes();
        break;
      case 6:
        print("¡Hasta luego!");
        return;
      default:
        print("Opción inválida");
    }
  }
}

void agregarEstudiante() {
  print("Ingrese el nombre del estudiante:");
  String nombre = stdin.readLineSync()!;
  print("Ingrese las calificaciones separadas por coma (ej: 8.5, 9, 7):");
  List<double> calificaciones =
      stdin.readLineSync()!.split(',').map(double.parse).toList();
  estudiantes.add(Estudiante(nombre, calificaciones));
  print("Estudiante agregado correctamente.");
}

void calcularPromedioEstudiante() {
  String nombre = stdin.readLineSync()!;
  Estudiante? estudiante = estudiantes.firstWhere((e) => e.nombre == nombre);

  print("El promedio de $nombre es: ${estudiante.calcularPromedio()}");
}

void calificacionesMasAltaYMasBaja() {
  if (estudiantes.isEmpty) {
    print("No hay estudiantes registrados.");
    return;
  }

  int numAsignaturas = estudiantes[0].calificaciones.length;
  List<double> maximos = List.filled(numAsignaturas, double.negativeInfinity);
  List<double> minimos = List.filled(numAsignaturas, double.infinity);

  for (Estudiante estudiante in estudiantes) {
    for (int i = 0; i < numAsignaturas; i++) {
      maximos[i] = max(maximos[i], estudiante.calificaciones[i]);
      minimos[i] = min(minimos[i], estudiante.calificaciones[i]);
    }
  }

  for (int i = 0; i < numAsignaturas; i++) {
    print(
        "Asignatura ${i + 1}: Máxima = ${maximos[i]}, Mínima = ${minimos[i]}");
  }
}

void estudiantesConPromedioSuperior() {
  print("Ingrese el promedio mínimo:");
  double promedioMinimo = double.parse(stdin.readLineSync()!);

  List<Estudiante> estudiantesAprobados =
      estudiantes.where((e) => e.calcularPromedio() > promedioMinimo).toList();

  if (estudiantesAprobados.isEmpty) {
    print("No hay estudiantes con un promedio superior a $promedioMinimo.");
  } else {
    print("Estudiantes con promedio superior a $promedioMinimo:");
    for (Estudiante estudiante in estudiantesAprobados) {
      print("- ${estudiante.nombre}: ${estudiante.calcularPromedio()}");
    }
  }
}

void ordenarEstudiantes() {
  print("1. Ordenar ascendente");
  print("2. Ordenar descendente");
  int opcion = int.parse(stdin.readLineSync()!);

  if (opcion == 1) {
    estudiantes
        .sort((a, b) => a.calcularPromedio().compareTo(b.calcularPromedio()));
  } else if (opcion == 2) {
    estudiantes
        .sort((a, b) => b.calcularPromedio().compareTo(a.calcularPromedio()));
  } else {
    print("Opción inválida.");
  }

  print("Estudiantes ordenados:");
  for (Estudiante estudiante in estudiantes) {
    print("- ${estudiante.nombre}: ${estudiante.calcularPromedio()}");
  }
}

class Estudiante {
  String nombre;
  List<double> calificaciones;

  Estudiante(this.nombre, this.calificaciones);

  double calcularPromedio() {
    return calificaciones.reduce((a, b) => a + b) / calificaciones.length;
  }
}

List<Estudiante> estudiantes = [];
