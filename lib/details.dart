import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TimeSelectSheet extends StatelessWidget {
  LatLng location;

  TimeSelectSheet(LatLng _location) {
    location = _location;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('Until when do you want to park?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.00,
                )),
            TimePicker(location),
          ],
        ));
  }
}

class TimePicker extends StatefulWidget {
  LatLng location;

  TimePicker(LatLng _location) {
    location = _location;
  }

  @override
  State createState() => TimePickerState(location);
}

class TimePickerState extends State<TimePicker> {
  DateTime _toDateTime = DateTime.now().add(Duration(hours: 1));
  String _licencePlate = "";
  LatLng location;

  TimePickerState(LatLng _location) {
    location = _location;
  }

  int _price = 0;
  final _pricePerMinute = 10;

  _calcPrice(int duration) {
    _price = duration * _pricePerMinute;
  }

  String _getPrice() {
    return (_price / 100).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _DateTimePicker(
          labelText: 'Until',
          selectedDate: _toDateTime,
          selectedTime:
              TimeOfDay(hour: _toDateTime.hour, minute: _toDateTime.minute),
          selectDate: setday,
          selectTime: setTime,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Licence Plate",
          ),
          autocorrect: false,
          textCapitalization: TextCapitalization.characters,
          maxLength: 12,
          onChanged: (licencePlate) => setState(() {
                _licencePlate = licencePlate;
              }),
        ),
        Text("Price: €${_getPrice()}"),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: RaisedButton(
            onPressed: () => _pay(
                _price, location, _licencePlate, DateTime.now(), _toDateTime),
            textColor: Theme.of(context).primaryTextTheme.body1.color,
            color: Theme.of(context).primaryColor,
            child: Text("Pay"),
          ),
        )
      ],
    );
  }

  setday(DateTime date) {
    setState(() {
      _toDateTime = DateTime(date.year, date.month, date.day, _toDateTime.hour,
          _toDateTime.minute);
      _calcPrice(_toDateTime.difference(DateTime.now()).inMinutes);
    });
  }

  setTime(TimeOfDay time) {
    setState(() {
      _toDateTime = DateTime(_toDateTime.year, _toDateTime.month,
          _toDateTime.day, time.hour, time.minute);
      _calcPrice(_toDateTime.difference(DateTime.now()).inMinutes);
    });
  }

  Future<void> _pay(int _amount, LatLng _location, String _licencePlate,
      DateTime _start, DateTime _end) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please pay ${_getPrice()} for your car with $_licencePlate.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Pay'),
              onPressed: () async {
                await Firestore.instance
                    .collection("tickets")
                    .document()
                    .setData({
                  "start": _start,
                  "end": _end,
                  "licencePlate": _licencePlate,
                  "paymentMethod": "ideal",
                  "price": _price,
                  "location": GeoPoint(_location.latitude, _location.longitude),
                  "user": userState.getID()
                });
                Navigator.of(context).pop();

                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Payment Success'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('The payment succeeded.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ]);
                  },
                );
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.add(Duration(days: -1)),
        lastDate: selectedDate.add(Duration(days: 6)));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}
