// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  get localeName => 'de';

  static m0(price, licencePlate) => "Bitte bezahlen Sie €${price} für Ihr Auto mit KFZ-Kennzeichen ${licencePlate}";

  static m1(price) => "Preis: €${price}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("Parking++"),
    "authenticate" : MessageLookupByLibrary.simpleMessage("Authentifizieren"),
    "authenticateMessage" : MessageLookupByLibrary.simpleMessage("Um loszulegen, melden Sie sich in Ihrem Google-Konto durch Drücken des Anmelde-Knopfes."),
    "cancelButton" : MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "continueToDetails" : MessageLookupByLibrary.simpleMessage("Weiter"),
    "help" : MessageLookupByLibrary.simpleMessage("Hilfe"),
    "helpDetailsText" : MessageLookupByLibrary.simpleMessage("Sie können nun eingeben die bis wann Sie parken möchten. Tippen Sie Dazu auf das Datum und/oder die Uhrzeit und wählen Sie ein Datum und eine Uhrzeit aus. Die maximale Parkdauer beträgt sieben Tage.\n\nSobald Sie ein Datum und eine Uhrzeit ausgewählt haben berechnet das System den Preis für das Park-Ticket. \n\nGeben Sie nun ihr KFZ-Kennzeichen im KFZ-Kennzeichen Feld ein. Wenn Sie dies nicht richtig eingeben erhalten Sie möglicherweise ein Ticket von einem Inspektor da dieser das Auto dann nicht ihnen zuordnen kann. \n\nSie können nun bezahlen. Tun Sie dies durch Drücken der Taste \"Bezahlen\". Folgen Sie die Anweisungen auf dem Bildschirm."),
    "helpDetailsTitle" : MessageLookupByLibrary.simpleMessage("Eingabe von details"),
    "helpHistoryText" : MessageLookupByLibrary.simpleMessage("Sie können Ihren Park Verlauf anzeigen, durch das Öffnen der Seite \"Verlauf\" im selben Menü wo sie auch diese Schaltfläche \"Hilfe\" finden.\n\nNun sehen Sie eine Liste Ihres Park Verlaufes. Jeder Eintrag zeigt an wann das sie das Ticket gekauft haben, die Dauer des Park-Tickets, der Standort und der \n\nEine detaillierte Karte von ihrem Parkplatz können sie sehen durch auf einen Eintrag zu Drücken. Eine Karte wird in dem unteren Teil des Bildschirms angezeigt. Um die Karte zu schließen, ziehen sie diese Mit einem Finger in Richtung des unteren Bildschirmrand."),
    "helpHistoryTitle" : MessageLookupByLibrary.simpleMessage("Park Verlauf"),
    "helpSelectParkingLocationText" : MessageLookupByLibrary.simpleMessage("Um Ihren Parkplatz-Standort auszuwählen, ziehen Sie die Karte mit einem Finger so das ihr Auto Standort unter dem Fadenkreuz in der Mitte des Bildschirms ist.\n\nSie können die Karte vergrößern und Verkleinern durch das auseinander schieben und zusammenführen von zwei Fingern auf dem Bildschirm.\n\nUm die Karte auf ihre aktuelle Position zu zentrieren drücken Sie das Kreissymbol  in der oberen rechten Ecke der Karte."),
    "helpSelectParkingLocationTitle" : MessageLookupByLibrary.simpleMessage("Wählen Sie Ihren Parkplatz-Standort aus"),
    "helpSupportText" : MessageLookupByLibrary.simpleMessage("Haben Sie Probleme mit der App oder Ihrem Parkticket? Rufen sie 1800-KPMHELP an. Wir sind für Sie 24/7 erreichbar."),
    "helpSupportTitle" : MessageLookupByLibrary.simpleMessage("Weitere Hilfe"),
    "history" : MessageLookupByLibrary.simpleMessage("Verlauf"),
    "licencePlate" : MessageLookupByLibrary.simpleMessage("KFZ-Kennzeichen"),
    "payButton" : MessageLookupByLibrary.simpleMessage("Bezahlen"),
    "paySuccessOKButton" : MessageLookupByLibrary.simpleMessage("Okay"),
    "paySuccessText" : MessageLookupByLibrary.simpleMessage("Die Zahlung ist es gelungen."),
    "paySuccessTitle" : MessageLookupByLibrary.simpleMessage("Zahlung erfolgreich"),
    "paymentAcceptText" : m0,
    "paymentAcceptTitle" : MessageLookupByLibrary.simpleMessage("Zahlung"),
    "price" : m1,
    "signin" : MessageLookupByLibrary.simpleMessage("Anmelden"),
    "signout" : MessageLookupByLibrary.simpleMessage("Ausloggen"),
    "until" : MessageLookupByLibrary.simpleMessage("Bis"),
    "untilWhenPark" : MessageLookupByLibrary.simpleMessage("Bis wann möchten Sie parken?")
  };
}
