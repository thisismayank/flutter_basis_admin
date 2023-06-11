import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/user_data_api.dart';

class RejectedUserCountPicker extends StatefulWidget {
  RejectedUserCountPicker(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.rootContext})
      : super(key: key);

  final String userId;
  final String authToken;
  final BuildContext rootContext;
  @override
  State<RejectedUserCountPicker> createState() =>
      _RejectedUserCountPickerState();
}

class _RejectedUserCountPickerState extends State<RejectedUserCountPicker> {
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  int rejectedUsersCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rejectedUsersCount = 0;
  }

  void getCount() async {
    UserPrepaidCardData userApi = UserPrepaidCardData();
    int rejectedUsersCountResponse = await userApi.getRejectedUserCount(
        selectedDates.start.toString(),
        selectedDates.end.toString(),
        widget.userId,
        widget.authToken,
        context);

    setState(() {
      rejectedUsersCount = rejectedUsersCountResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(-4, 4),
                      color: Color.fromARGB(0, 255, 255, 255)),
                  BoxShadow(
                      blurRadius: 6,
                      offset: Offset(4, 4),
                      color: Color.fromARGB(48, 0, 0, 0))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: const [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xff5ECD9B),
                  ),
                  Text(" Rejected Count",
                      style: TextStyle(
                          color: Color(0xff5ECD9B),
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          onTap: () async {
            final DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2022),
                lastDate: DateTime(3000),
                builder: (context, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 400.0,
                            maxHeight:
                                MediaQuery.of(context).size.height - 200),
                        child: child,
                      )
                    ],
                  );
                });
            if (dateTimeRange != null) {
              setState(() {
                selectedDates = dateTimeRange;
              });
              getCount();
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        rejectedUsersCount > 0
            ? Center(
                child: Column(
                  children: [
                    Text(
                      '${selectedDates.start.day}/${selectedDates.start.month}/${selectedDates.end.year} - ${selectedDates.end.day}/${selectedDates.end.month}/${selectedDates.end.year}',
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.amberAccent,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$rejectedUsersCount',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.amberAccent,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
