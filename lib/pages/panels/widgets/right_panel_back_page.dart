import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/geo_data_map.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'dart:math';

/// This widget will be the root of application.

/// This widget is the home page of the application.
class RightPanelBackPage extends StatelessWidget {
  /// Initialize the instance of the [RightPanelBackPage] class.
  const RightPanelBackPage(
      {Key? key,
      required this.geoData,
      required this.refreshTime,
      required this.cityToTransactionData})
      : super(key: key);
  final List geoData;
  final String refreshTime;
  final Map cityToTransactionData;
  @override
  Widget build(BuildContext context) {
    List<Widget> listData = [];
    cityToTransactionData.forEach((key, value) {
      listData.add(Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: CircleAvatar(
            radius: 15,
            child: Text('${key.substring(0, 1).toUpperCase()}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          title: Text(key),
          trailing: Text('₹${value.toStringAsFixed(2)}'),
        ),
      ));
      // return Container();
    });
    // print('listadata $listData');
    return SingleChildScrollView(
      child: Container(
        // color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width - 50,
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Stack(children: [
                  InteractiveViewer(child: GeoDataMapPage(geoData: geoData)),
                  Positioned.directional(
                      textDirection: TextDirection.ltr,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.refresh,
                                  size: 14, color: Color(0xff36c182)),
                              Text(
                                refreshTime,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff36c182)),
                              ),
                            ],
                          ),
                        ),
                      ))
                ])),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: [Text('${refreshTime}')],
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 300,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: const Center(
                            child: Text(
                              'City wise Transaction Data',
                              style: TextStyle(
                                  color: Color(0xff36c182),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                  // backgroundColor: Color(0xff36c182),
                                  ),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 20,
                      child: Container(
                        width: 300,
                        child: ListView(
                          children: listData,
                        ),
                      ),
                    ),
                    // Spacer(
                    //   flex: 1,
                    // ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.

