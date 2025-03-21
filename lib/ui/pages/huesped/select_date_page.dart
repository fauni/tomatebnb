import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
// import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
// import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/reserve/accommodation_availability_response_model.dart';

import 'package:tomatebnb/utils/customwidget.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({super.key});

  @override
  State<SelectDatePage> createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  List<DateTime> _activeDates = [];
  @override
  void initState() {
    super.initState();

    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    _activeDates = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
      today.add(const Duration(days: 3)),
      today.add(const Duration(days: 4)),
      today.add(const Duration(days: 5)),
      today.add(const Duration(days: 14)),
      today.add(const Duration(days: 15)),
    ];
  }

  final calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(const Duration(days: 365)),
    onRangeSelected: (firstDate, secondDate) {
      print(firstDate.toString());
      print(secondDate.toString());
    },
    onDayTapped: (date) {},
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
    // initialFocusDate: DateTime(2023, 5),
    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime(2022, 3, 20),
  );
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  final DateRangePickerController _controller = DateRangePickerController();
  late AccommodationResponseCompleteModel _accommodation =
      AccommodationResponseCompleteModel();
  List<AccommodationAvailabilityResponseModel> occupieds = [];
  @override
  Widget build(BuildContext context) {
    _accommodation =
        GoRouterState.of(context).extra as AccommodationResponseCompleteModel;
    // _accommodation.createdAt=null;
    // _accommodation.updatedAt=null;
    if (_accommodation.id != null) {
      context
          .read<AccommodationAvailabilityBloc>()
          .add(AccommodationAvailabilityGetEvent(_accommodation.id!));
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Elija fechas",
          style: TextStyle(fontFamily: "Gilroy Bold"),
        ),
        actions: [
          Ink(
            height: 40,
            decoration:
                ShapeDecoration(color: Colors.grey[300], shape: CircleBorder()),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          BlocConsumer<AccommodationAvailabilityBloc, AccommodationAvailabilityState>(
            listener: (context, state) {
              // TODO: implement listener
              if(state is AccommodationAvailabilityGetError){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
              }
              if(state is AccommodationAvailabilityGetSuccess){
                occupieds = state.responseAccommodationAvailabilitys;
              }
            },
            builder: (context, state) {
              if(state is AccommodationAvailabilityGetLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              return Expanded(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SfDateRangePicker(
                    controller: _controller,
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.range,
                    enablePastDates: false,
                    minDate: DateTime.now().add(Duration(days: 1)),
                    maxDate: DateTime.now().add(Duration(days: 365)),
                    // initialSelectedRange:
                    // PickerDateRange(_activeDates[0], _activeDates[5]),
                    startRangeSelectionColor:
                        Theme.of(context).colorScheme.primary,
                    endRangeSelectionColor:
                        Theme.of(context).colorScheme.primary,
                    rangeSelectionColor:
                        Theme.of(context).colorScheme.secondary,
                    //  onSelectionChanged: selectionChanged,
                    onSelectionChanged: _onSelectionChanged,
                    selectableDayPredicate: predicateCallback,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      disabledDatesTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 13,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
              padding: EdgeInsets.all(12.0),
              child: AppButton(
                  context: context,
                  onclick: () {
                    print(_accommodation.createdAt.toString());
                    print(_accommodation.updatedAt.toString());

                    if ((_accommodation.createdAt ?? DateTime.now())
                            .isBefore(DateTime.now()) ||
                        (_accommodation.updatedAt ?? DateTime.now())
                            .isBefore(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Elija fecha validas por favor'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ));
                    } else {
                      context.push('/create_reserve', extra: _accommodation);
                    }
                  },
                  buttontext: "Continuar"))
        ],
      ),
      // ScrollableCleanCalendar(
      //   locale: 'es',
      //   calendarController: calendarController,
      //   layout: Layout.BEAUTY,
      //   calendarCrossAxisSpacing: 0,
      //   // dayBuilder: (context, values) {
      //   //   if(values.isFirstDayOfWeek){
      //   //     return(
      //   //       IconButton
      //   //     );
      //   //   }
      //   //   return Container();
      //   //   }
      // ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _accommodation.createdAt = args.value.startDate;
      _accommodation.updatedAt = args.value.endDate;
      // print(_accommodation.createdAt.toString());
      // print(_accommodation.updatedAt.toString());
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _controller.selectedRange =
        PickerDateRange(_activeDates[0], _activeDates[5]);
  }

  bool predicateCallback(DateTime date) {
    for (int i = 0; i < occupieds.length; i++) {
      if (occupieds[i].startDate == date) {
        return false;
      }
    }
    return true;
  }
}
