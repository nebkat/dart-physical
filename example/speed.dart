import 'package:physical/quantities.dart';
import 'package:physical/system/si.dart' as si;
import 'package:physical/system/international.dart' as intl;

void main() {
  // How far we travelled
  final d = Length.of(240, intl.mile);
  // How long it took
  final t = Time.of(5, si.hour);
  // How fast we were going
  final s = Speed(d / t);

  print(s);
  print(s[si.metre.kilo / si.hour]);
  print(s[si.metre / si.second]);

  print("\n===");

  // How far will we travel in 30 minutes
  final d2 = s * Time.of(30, si.minute);
  print(d2); // 1440.0 [mi/h]·min - correct, but not very useful
  print(d2[intl.mile].round());
  print(d2[si.metre].round());

  print("\n===");

  // How long will it take to travel 100 miles at this speed?
  final time2 = Time(d / s);
  print(time2); // 5.0 mi/[mi/h] - correct, but not very useful
  print(time2[si.hour].round());
  print(time2[si.minute].round());
}
