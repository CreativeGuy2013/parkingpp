import 'package:flutter/material.dart';
import 'dart:math';

class HelpPage extends StatelessWidget {
  final pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: new Stack(
        fit: StackFit.expand,
        alignment: FractionalOffset.bottomCenter,
        children: <Widget>[
          PageView(
            controller: pageController,
            children: <Widget>[
              HelpPageSelectParkingLocation(),
              HelpPageDetails(),
              HelpPageHistory(),
              HelpPageSupport(),
            ],
          ),
          new Positioned(
            bottom: 20,
            child: new DotsIndicator(
              controller: pageController,
              itemCount: 4,
              color: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpPageSelectParkingLocation extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Select your Parking Location \n",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            """
To select your parking location, drag the map with one finger so your cars location is under the crosshair in the center of the screen.\n
You can zoom in and out of the map by putting two fingers on the display and moving them towards and apart from each other without letting go of the screen. \n
To center the map to your current location press the circle icon on the map in the top right corner.
            """,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpPageDetails extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Entering details \n",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            """
You can now enter the until when you want to park. Do this by tapping on the date and/or time selectors and choosing a date/time. The maximum parking duration is seven days.\n
Once you have selected a date and time the system will calculate the price for the parking. \n
In the Licence Plate field enter your licence plate. If you don't enter this correctly you might recieve a ticket from an inspector. \n
You can now pay. Do this by pressing the "Pay" button. Follow the on screen instructions for payment.
            """,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpPageHistory extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Parking History \n",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            """
You can view your parking history by opening the "Parking History" page from the same menu as this help button. \n
You will see a list of your whole parking history. Every entry shows the time parking started, the duration, the location and the price. \n
To see a detailed map of where you parked press on an individual entry. A map will appear on the bottom of the screen. To close the map swipe down on it.
            """,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpPageSupport extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Further support \n",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            """
Are you having any issues with the app or your parking ticket? Call 1800-KPMHELP. We are available for you 24/7.
            """,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}


class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
