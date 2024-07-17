import 'package:flutter/material.dart';
import 'package:tripplannerai/models/itinerary_model.dart';
import 'package:tripplannerai/screens/itinerary_details/user_trip_plan_data.dart';
import 'package:tripplannerai/services/itinerary_service.dart';

class ItineraryDetailsScreen extends StatefulWidget {
  final UserTripPlanData? userTripPlanData;

  const ItineraryDetailsScreen({super.key, this.userTripPlanData});

  @override
  State<ItineraryDetailsScreen> createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  late Future<ItineraryResult> _itineraryRes;

  @override
  void initState() {
    super.initState();
    if (widget.userTripPlanData != null) {
      _getItineraryData(widget.userTripPlanData);
    }
  }

  _getItineraryData(UserTripPlanData? itineraryDetailsScreenArguments) {
    _itineraryRes = ItineraryService().getItineraryData(
        city: itineraryDetailsScreenArguments!.cityName,
        start_date: itineraryDetailsScreenArguments.startDate,
        end_date: itineraryDetailsScreenArguments.endDate,
        activities: itineraryDetailsScreenArguments.interestedActivities);
    print('iternaernay Res:::\n ${_itineraryRes}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trip Plan AI'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(children: [
                        Container(
                          height: 200,
                          // width: 200,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: Image.network(
                                  'https://picsum.photos/200/200?grayscale',
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: const Color.fromRGBO(255, 255, 255, 0.7),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.userTripPlanData!.cityName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ExpansionTile(
                                        initiallyExpanded: index == 0,
                                        collapsedTextColor: Colors.white,
                                        collapsedBackgroundColor: Colors.black,
                                        title: Text(
                                          '${snapshot.data?.plans[index].day}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                            '${snapshot.data?.plans[index].description}'),
                                        children: [
                                          ...snapshot
                                              .data!.plans[index].activities
                                              .map(
                                            (activity) => Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Colors.black),
                                                    child: Text(
                                                      // textWidthBasis: TextWidthBasis.parent,
                                                      activity.slot
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ), //text

                                                  ...activity.slotDescription
                                                      .map(
                                                    (desc) => Text(
                                                        desc.trimLeft(),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                  // Card(child: Text('hi'),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: snapshot.data!.plans.length,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Failed To Load Data: ${snapshot.error}'),
              );
            }
            return const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          },
          future: _itineraryRes,
        ));
  }
}
