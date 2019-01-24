// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'nl';

  static m0(price, licencePlate) => "Betaal €${price} voor uw auto met kenteken ${licencePlate}";

  static m1(price) => "Prijs: €${price}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("Parking++"),
    "authenticate" : MessageLookupByLibrary.simpleMessage("Inloggen"),
    "authenticateMessage" : MessageLookupByLibrary.simpleMessage("Om te beginnen druk de knop hieronder om met uw Google-account in te loggen."),
    "cancelButton" : MessageLookupByLibrary.simpleMessage("Afbreken"),
    "continueToDetails" : MessageLookupByLibrary.simpleMessage("Verder"),
    "help" : MessageLookupByLibrary.simpleMessage("Help"),
    "helpDetailsText" : MessageLookupByLibrary.simpleMessage("You can now enter the until when you want to park. Do this by tapping on the date and/or time selectors and choosing a date/time. The maximum parking duration is seven days.\n\nOnce you have selected a date and time the system will calculate the price for the parking. \n\nIn the Licence Plate field enter your licence plate. If you don\'t enter this correctly you might recieve a ticket from an inspector. \n\nYou can now pay. Do this by pressing the \"Pay\" button. Follow the on screen instructions for payment.\n            "),
    "helpDetailsTitle" : MessageLookupByLibrary.simpleMessage("Entering details"),
    "helpHistoryText" : MessageLookupByLibrary.simpleMessage("You can view your parking history by opening the \"Parking History\" page from the same menu as this help button. \n\nYou will see a list of your whole parking history. Every entry shows the time parking started, the duration, the location and the price. \n\nTo see a detailed map of where you parked press on an individual entry. A map will appear on the bottom of the screen. To close the map swipe down on it.\n            "),
    "helpHistoryTitle" : MessageLookupByLibrary.simpleMessage("Parking History"),
    "helpSelectParkingLocationText" : MessageLookupByLibrary.simpleMessage("To select your parking location, drag the map with one finger so your cars location is under the crosshair in the center of the screen.\n\nYou can zoom in and out of the map by putting two fingers on the display and moving them towards and apart from each other without letting go of the screen. \n\nTo center the map to your current location press the circle icon on the map in the top right corner.\n            "),
    "helpSelectParkingLocationTitle" : MessageLookupByLibrary.simpleMessage("Selecteer uw parkeer locatie"),
    "helpSupportText" : MessageLookupByLibrary.simpleMessage("Are you having any issues with the app or your parking ticket? Call 1800-KPMHELP. We are available for you 24/7.\n            "),
    "helpSupportTitle" : MessageLookupByLibrary.simpleMessage("Further support"),
    "history" : MessageLookupByLibrary.simpleMessage("Geschiedenis"),
    "licencePlate" : MessageLookupByLibrary.simpleMessage("Kenteken"),
    "payButton" : MessageLookupByLibrary.simpleMessage("Betalen"),
    "paySuccessOKButton" : MessageLookupByLibrary.simpleMessage("OK"),
    "paySuccessText" : MessageLookupByLibrary.simpleMessage("De betaling is geslaagd."),
    "paySuccessTitle" : MessageLookupByLibrary.simpleMessage("Betaling succes"),
    "paymentAcceptText" : m0,
    "paymentAcceptTitle" : MessageLookupByLibrary.simpleMessage("Betaling"),
    "price" : m1,
    "signin" : MessageLookupByLibrary.simpleMessage("Aanmelden"),
    "signout" : MessageLookupByLibrary.simpleMessage("Afmelden"),
    "until" : MessageLookupByLibrary.simpleMessage("Tot"),
    "untilWhenPark" : MessageLookupByLibrary.simpleMessage("Tot wanneer wilt u parkeren?")
  };
}
