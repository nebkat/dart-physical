import 'package:physical/physical.dart';

void main() {
  // How far we travelled
  final distance = Length(240, mile);
  // How long it took
  final time = Time.hours(5);

  // How fast we were going
  final speed = Speed.from(distance / time);

  print(speed);
  print(speed.inUnits(metre.kilo / hour));
  print(speed.inUnits(metre / second).round());

  print("===");

  // How far will we travel in 30 minutes
  final distance2 = speed * Time.minutes(30);
  print(distance2); // 1440.0 [mi/h]·min - correct, but not very useful
  print(distance2.inUnits(mile).round());
  print(distance2.inUnits(metre).round());

  print("===");

  // How long will it take to travel 100 miles at this speed?
  final time2 = Time.from(distance / speed);
  print(time2); // 5.0 mi/[mi/h] - correct, but not very useful
  print(time2.inUnits(hour).round());
  print(time2.inUnits(minute).round());

  print("===");

  final speed2 = speed * 2;
  print(speed2);
}
