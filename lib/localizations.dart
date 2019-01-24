import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //Auth message

  String get authenticate {
    return Intl.message('Authenticate', name: 'authenticate');
  }

  String get authenticateMessage {
    return Intl.message(
        'To get started, please sign in to your Google account by pressing the button below.',
        name: 'authenticateMessage',
        desc:
            "tell the user to press signin button (google) (below this text).");
  }

  String get signin {
    return Intl.message('Sign in', name: 'signin');
  }

  String get signout {
    return Intl.message('Sign out', name: 'signout');
  }

  //Dropdown options menu
  String get history {
    return Intl.message('History', name: 'history', desc: "parking history");
  }

  String get help {
    return Intl.message('Help', name: 'help');
  }

  //FAB descriptions
  String get continueToDetails {
    return Intl.message('Continue', name: 'continueToDetails');
  }

  //App name
  String get appName {
    return Intl.message('Parking++', name: 'appName');
  }

  //Details menu
  String get untilWhenPark {
    return Intl.message('Until when do you want to park?',
        name: 'untilWhenPark',
        desc: "question asking until when you want to park");
  }

  String get until {
    return Intl.message('Until',
        name: 'until', desc: "text above until time dropdown in details menu");
  }

  String get licencePlate {
    return Intl.message('Licence Plate',
        name: 'licencePlate', desc: "text for licence plate text field");
  }

  String price(String price) => Intl.message(
        'Price: €$price',
        name: 'price',
        args: [price],
      );

  String get payButton {
    return Intl.message('Pay', name: 'payButton', desc: "pay button text");
  }

  //Payment alert
  String get paymentAcceptTitle {
    return Intl.message('Payment', name: 'paymentAcceptTitle', desc: "pay alert 1 title");
  }

  String paymentAcceptText(String price, String licencePlate) => Intl.message(
        'Please pay €$price for your car with licence plate $licencePlate',
        name: 'paymentAcceptText',
        args: [price, licencePlate],
      );

  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton');
  }

  //Pay success alert
  String get paySuccessTitle {
    return Intl.message('Payment Success', name: 'paySuccessTitle');
  }

  String get paySuccessText {
    return Intl.message('The payment succeeded.', name: 'paySuccessText');
  }

  String get paySuccessOKButton {
    return Intl.message('OK', name: 'paySuccessOKButton');
  }

  //Help Page Select Parking Location
  String get helpSelectParkingLocationTitle {
    return Intl.message('Select your Parking Location',
        name: 'helpSelectParkingLocationTitle');
  }

  String get helpSelectParkingLocationText {
    return Intl.message("""
To select your parking location, drag the map with one finger so your cars location is under the crosshair in the center of the screen.\n
You can zoom in and out of the map by putting two fingers on the display and moving them towards and apart from each other without letting go of the screen. \n
To center the map to your current location press the circle icon on the map in the top right corner.
            """, name: 'helpSelectParkingLocationText');
  }

  //Help Page Details
  String get helpDetailsTitle {
    return Intl.message('Entering details', name: 'helpDetailsTitle');
  }

  String get helpDetailsText {
    return Intl.message("""
You can now enter the until when you want to park. Do this by tapping on the date and/or time selectors and choosing a date/time. The maximum parking duration is seven days.\n
Once you have selected a date and time the system will calculate the price for the parking. \n
In the Licence Plate field enter your licence plate. If you don't enter this correctly you might recieve a ticket from an inspector. \n
You can now pay. Do this by pressing the "Pay" button. Follow the on screen instructions for payment.
            """, name: 'helpDetailsText');
  }

  //Help Page History
  String get helpHistoryTitle {
    return Intl.message('Parking History', name: 'helpHistoryTitle');
  }

  String get helpHistoryText {
    return Intl.message("""
You can view your parking history by opening the "Parking History" page from the same menu as this help button. \n
You will see a list of your whole parking history. Every entry shows the time parking started, the duration, the location and the price. \n
To see a detailed map of where you parked press on an individual entry. A map will appear on the bottom of the screen. To close the map swipe down on it.
            """, name: 'helpHistoryText');
  }

  //Help Page Select Parking Location
  String get helpSupportTitle {
    return Intl.message('Further support',
        name: 'helpSupportTitle');
  }

  String get helpSupportText {
    return Intl.message("""
Are you having any issues with the app or your parking ticket? Call 1800-KPMHELP. We are available for you 24/7.
            """, name: 'helpSupportText');
  }


}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'nl', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
