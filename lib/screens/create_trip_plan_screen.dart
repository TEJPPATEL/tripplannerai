import 'dart:ui';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tripplannerai/models/city_model.dart';
import 'package:tripplannerai/screens/itinerary_details/itinerary_details_screen.dart';
import 'package:tripplannerai/screens/itinerary_details/user_trip_plan_data.dart';
import 'package:tripplannerai/utilites/city_service.dart';
import 'package:tripplannerai/utilites/text_const.dart';

class CreateTripPlanScreen extends StatefulWidget {
  CreateTripPlanScreen({super.key});

  @override
  State<CreateTripPlanScreen> createState() => _CreateTripPlanScreenState();
}

class _CreateTripPlanScreenState extends State<CreateTripPlanScreen> {
  final List<Map<String, dynamic>> acitivityChips = [
    {
      'id': 1,
      'icon': Icons.emoji_people,
      'label': 'Kid Friendly',
      'selected': false
    },
    {
      'id': 2,
      'icon': Icons.add_to_drive_outlined,
      'label': 'Outdoor Adventures',
      'selected': false
    },
    {
      'id': 3,
      'icon': Icons.shopping_bag,
      'label': 'Shopping',
      'selected': false
    },
    {
      'id': 4,
      'icon': Icons.location_history,
      'label': 'Historical',
      'selected': false
    },
    {
      'id': 5,
      'icon': Icons.art_track,
      'label': 'Art & Cultural',
      'selected': false
    },
    {
      'id': 6,
      'icon': Icons.museum_sharp,
      'label': 'Museums',
      'selected': false
    },
    {
      'id': 7,
      'icon': Icons.park,
      'label': 'Amusement Parks',
      'selected': false
    },
  ];

  List<City>? _cities;
  var _isExpandDateRange = false;
  TextEditingController cityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<String> chosenActivityChips = [];
  Map<String, String> selectedDateRange = {'startDate': '', 'endDate': ''};

  @override
  initState() {
    super.initState();
    _getCities();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
    dateController.dispose();
  }

  void _getCities() async {
    _cities = await CityService().getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                TextConstant.createPlanTitle,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
              const Text(
                TextConstant.whereToVisit,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TypeAheadField(
                itemBuilder: (context, City cityObj) {
                  return ListTile(
                    title: Text('${cityObj.name} , ${cityObj.state}, IN'),
                  );
                },
                onSelected: _onSelectCity,
                suggestionsCallback: getCitiesSuggestion,
                controller: cityController,
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: cityController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter City Name Wanted to Visit'),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // readOnly: true,

                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Choose Date Range',
                  labelText: 'Date Range',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.calendar_month),
                  // prefix: Icon(Icons.calendar_month)
                ),
                // prefix: Icon(Icons.date_range), hintText: "Select Date"),
                onTap: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close')),
                              ),
                              RangeDatePicker(
                                centerLeadingDate: true,
                                minDate: _getCurrentDate(),
                                maxDate: _getMaxDate(),
                                initialDate: null,
                                // selectedRange: null,
                                selectedRange:
                                    selectedDateRange['startDate']!.isEmpty
                                        ? null
                                        : DateTimeRange(
                                            start: DateTime.parse(
                                                selectedDateRange['startDate']!
                                                    .replaceAll('/', '-')),
                                            end: DateTime.parse(
                                                selectedDateRange['endDate']!
                                                    .replaceAll('/', '-'))),
                                onRangeSelected: (value) {
                                  final stratDate = value.start
                                      .toString()
                                      .replaceAll('-', '/')
                                      .split(' ')[0];
                                  selectedDateRange['startDate'] = stratDate;
                                  final endDate = value.end
                                      .toString()
                                      .replaceAll('-', '/')
                                      .split(' ')[0];
                                  selectedDateRange['endDate'] = endDate;
                                  final formattedDate = '$stratDate - $endDate';

                                  // if (end_date.isNotEmpty &&
                                  //     strat_date != end_date) {
                                  //   formattedDate += ' - ${end_date}';
                                  // }
                                  dateController.text = formattedDate;
                                },
                              )
                            ],
                          ),
                        );
                      })
                  // setState(() {
                  //   // _isExpandDateRange = !_isExpandDateRange;
                  // })
                },
              ),
              // _isExpandDateRange
              //     ? RangeDatePicker(
              //         centerLeadingDate: true,
              //         minDate: _getCurrentDate(),
              //         maxDate: _getMaxDate(),
              //         onRangeSelected: (value) {
              //           final strat_date = value.start.toString().split(' ')[0];
              //           final end_date = value.end.toString().split(' ')[0];
              //           var formattedDate = strat_date;
              //           if (end_date.isNotEmpty && strat_date != end_date) {
              //             formattedDate += '- ${end_date}';
              //           }
              //           dateController.text = formattedDate;
              //         },
              //       )
              //     : const SizedBox(
              //         height: 0,
              //       ),
              const SizedBox(height: 20),
              const Text(
                'Select the kind of activities you want to do',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                // alignment: WrapAlignment.spaceBetween,
                children: [
                  ...acitivityChips.map((chip) => ActivityChip(
                        chip: chip,
                        callback: _onSelectChip,
                      ))
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (dateController.text.isEmpty ||
                      cityController.text.isEmpty) {
                    return;
                  }
                  final interestedActivities = acitivityChips
                      .where((act) => act['selected'])
                      .map((act) => act['label']);

                  final Map<String, dynamic> itineraryDetailsScreenArguments = {
                    'cityName': cityController.text,
                    'startDate': dateController.text.split(' - ')[0],
                    'endDate': dateController.text.split(' - ')[1],
                    'interestedActivities': interestedActivities.join(',')
                  };
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItineraryDetailsScreen(
                          userTripPlanData: UserTripPlanData(
                              cityName:
                                  itineraryDetailsScreenArguments['cityName'],
                              startDate:
                                  itineraryDetailsScreenArguments['startDate'],
                              endDate:
                                  itineraryDetailsScreenArguments['endDate'],
                              interestedActivities:
                                  itineraryDetailsScreenArguments[
                                      'interestedActivities']))));

                  // pushReplacementNamed(
                  //     ScreenRoute.itineraryDetails,
                  //     arguments: itineraryDetailsScreenArguments);
                  print(itineraryDetailsScreenArguments);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        dateController.text.isEmpty ||
                                cityController.text.isEmpty
                            ? Colors.grey
                            : Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: const Text('Create Trip',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<City> getCitiesSuggestion(String pattern) {
    return (_cities != null)
        ? _cities!
            .where((city) =>
                city.name.toLowerCase().contains(pattern.toLowerCase()))
            .toList()
        : [];
  }

  void _onSelectCity(City city) {
    cityController.text = city.name;
    print(city.name);
  }

  DateTime _getCurrentDate() {
    return DateTime.now();
  }

  DateTime _getMaxDate() {
    final currentDate = _getCurrentDate();
    final currentYear = currentDate.year;
    return DateTime(currentYear, 12, 31);
  }

  _onSelectChip(Map<String, dynamic> chip) {
    setState(() {
      acitivityChips.firstWhere(
              (element) => element['id'] == chip['id'])['selected'] =
          !chip['selected'];
    });
  }
}

class ActivityChip extends StatelessWidget {
  final Function callback;
  final Map<String, dynamic> chip;

  const ActivityChip({super.key, required this.chip, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: chip['selected'] ? Colors.black : Colors.grey.withOpacity(0.1),
          border: Border.all(
              color: chip['selected']
                  ? Colors.black
                  : Colors.grey.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () => callback(chip),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              chip['icon'],
              color: chip['selected'] ? Colors.white : Colors.black,
            ),
            Text(
              chip['label'],
              style: TextStyle(
                  color: chip['selected'] ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
