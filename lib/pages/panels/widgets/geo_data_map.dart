import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'dart:math' as math;

/// This widget will be the root of application.

/// This widget is the home page of the application.
class GeoDataMapPage extends StatefulWidget {
  /// Initialize the instance of the [GeoDataMapPage] class.
  const GeoDataMapPage({Key? key, required this.geoData}) : super(key: key);
  final List geoData;

  @override
  State<GeoDataMapPage> createState() => _GeoDataMapPageState();
}

class _GeoDataMapPageState extends State<GeoDataMapPage> {
  _GeoDataMapPageState();

  late List<Model> _data;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    _data = widget.geoData.map((e) {
      String cityData = "${e["state"]}\n\nTOTAL - ${e["totalCount"]}\n";
      e["cities"].forEach((city) {
        cityData = '$cityData\n ${city["city"]}: ${city["countHere"]}';
      });
      return Model(
          '${e["state"]}',
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          cityData);
    }).toList();
    // [
    //   Model(
    //       'Chandigarh', Color.fromRGBO(255, 215, 0, 1.0), '       Chandigarh'),
    //   Model('Delhi', Color.fromARGB(255, 237, 237, 237), 'New\nDelhi'),
    //   Model('Haryana', Color.fromARGB(255, 0, 255, 68), 'Haryana'),
    //   Model('Kerala', Color.fromRGBO(255, 215, 0, 1.0), 'Kerala'),
    //   Model('Lakshadweep', Color.fromRGBO(255, 215, 0, 1.0), 'Lakshadweep'),
    //   Model('Orissa', Color.fromRGBO(255, 215, 0, 1.0), 'Orissa'),
    //   Model('Himachal Pradesh', Color.fromRGBO(255, 215, 0, 1.0),
    //       '       NewHimachal Pradesh'),
    //   // Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
    //   //     '       New\nSouth Wales'),
    //   // Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
    //   // Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
    //   //     'Northern\nTerritory'),
    //   // Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
    //   // Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
    //   //     'South Australia'),
    //   // Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
    //   //     'Western Australia'),
    //   // Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
    //   // Model('Australian Capital Territory', Colors.teal, 'ACT')
    // ];

    _mapSource = MapShapeSource.asset(
      'assets/india.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      // dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Center(
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                showDataLabels: false,
                // legend: const MapLegend(MapElement.shape,
                //     direction: Axis.vertical,
                //     position: MapLegendPosition.left,
                //     iconType: MapIconType.rectangle,
                //     spacing: 6),
                tooltipSettings: const MapTooltipSettings(
                    color: Color(0xff5ecd98),
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 0.5,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _data[index].stateCode,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                dataLabelSettings: MapDataLabelSettings(
                    textStyle: TextStyle(
                        // color: Color.fromARGB(255, 76, 223, 140),
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.caption!.fontSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}
