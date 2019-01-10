import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSelectSheet extends StatefulWidget {
  @override
  State createState() => TimeSelectSheetState();
}

class TimeSelectSheetState extends State<TimeSelectSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Text('Until when do you want to park?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00,
                    )),
                TimePicker(),
              ],
            )));
  }
}

class TimePicker extends StatefulWidget {
  @override
  State createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  DateTime _toDateTime = DateTime.now();
  String _numberPlate = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _DateTimePicker(
          labelText: 'From',
          selectedDate: _toDateTime,
          selectedTime:
              TimeOfDay(hour: _toDateTime.hour, minute: _toDateTime.minute),
          selectDate: (DateTime date) {
            setState(() {
              _toDateTime = date;
            });
          },
          selectTime: (TimeOfDay time) {
            setState(() {
              _toDateTime = DateTime(_toDateTime.year, _toDateTime.month,
                  _toDateTime.day, time.hour, time.minute);
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Licence Plate",
          ),
          autocorrect: false,
          textCapitalization: TextCapitalization.characters,
          maxLength: 12,

          onChanged: (numberPlate) => setState(() {
            _numberPlate = numberPlate;
          }),
        ),
        Text("Price: € ${(((_toDateTime.difference(DateTime.now()).inMinutes / 10).round() * 20) / 100)}"),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: RaisedButton(
            onPressed: () => _pay(),
            textColor: Theme.of(context).primaryTextTheme.body1.color,
            color: Theme.of(context).primaryColor,
            child: Text("Pay"),
          ),
        )
      ],
    );
  }

  Future<void> _pay() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pay'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You would now fill in your payment information.'),
                Text(
                    'We have emailed you a reciept for your parking ticket with car $_numberPlate. Thank you.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    var _initTime =
        TimeOfDay(hour: _toDateTime.hour, minute: _toDateTime.minute);

    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _initTime);
    if (picked != null && picked != _initTime)
      setState(() {
        _toDateTime = DateTime(_toDateTime.year, _toDateTime.month,
            _toDateTime.day, picked.hour, picked.minute);
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 3)),
        context: context,
        initialDate: _toDateTime);
    if (picked != null && picked != _toDateTime)
      setState(() {
        _toDateTime = DateTime(_toDateTime.year, _toDateTime.month,
            _toDateTime.day, picked.hour, picked.minute);
      });
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
