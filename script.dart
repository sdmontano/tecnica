import 'dart:io';

void main(List<String> args) {
  List<String> estados = new List.empty(growable: true);
  List<List<String>> valoresSep = new List.empty(growable: true);
  int sumaPoblacion = 0;
  int covidMuertes = 0;
  double? porceMuertes;
  String estadoMay = "";
  String estadoMen = "";
  String afectado = "";
  int valMenor = 99999999;
  int valMayor = -5;
  double? valMayor2 = -9999;

  final items = File("time_series_covid19_deaths_US.csv").readAsLinesSync();
  items.removeAt(0);

  for (var item in items) {
    final valores = item.split(',');
    valoresSep.add(valores);
    estados.add(valores[6]);
  }

  var norepit = estados.toSet();
  estados = norepit.toList();

  for (var i = 0; i < estados.length; i++) {
    sumaPoblacion = 0;
    covidMuertes = 0;
    var temp = valoresSep.where((element) => element[6] == estados[i]).toList();
    temp.forEach((element) {
      covidMuertes = covidMuertes + int.parse(element[element.length - 1]);
      sumaPoblacion = sumaPoblacion + int.parse(element[13]).toInt();
      porceMuertes = ((covidMuertes * 100) / sumaPoblacion).toDouble();
    });

    print(
        'EL estado de ${estados[i]} tiene una tasa de muerte del $porceMuertes');

    if (covidMuertes > valMayor) {
      valMayor = covidMuertes;
      estadoMay = estados[i];
    }

    if (covidMuertes < valMenor) {
      valMenor = covidMuertes;
      estadoMen = estados[i];
    }

    if (porceMuertes! < 1) {
      if (porceMuertes! > valMayor2!) {
        valMayor2 = porceMuertes;
        afectado = estados[i];
      }
    }
  }

  print(
      'El estado con mayor muertes Covid acumulado a la fecha es $estadoMay con una cantidad de $valMayor');

  print(
      'El estado con menor muertes Covid acumulado a la fecha es $estadoMen con una cantidad de $valMenor');

  print(
      'El esta domas afectado hasta la fecha es $afectado ya que tiene el porcentaje mas alto de muertes con respecto a su poblacion total: $valMayor2');
}
