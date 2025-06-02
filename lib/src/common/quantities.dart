import '../core/quantity.dart';
import '../core/unit.dart';
import '../common/units.dart';
import '../system/si.dart';
import '../system/usc.dart';
import 'dimensions.dart';

extension type Scalar._(Quantity q) implements Quantity {
  Scalar.from(this.q) : assert(q.dimensions == dimensionless);
  const Scalar.zero() : q = const Quantity(0, one);
  Scalar(num value, Unit unit) : this.from(Quantity(value, unit));
  Scalar.one(num value) : this(value, one);
  Scalar.percent(num value) : this(value, percent);
  Scalar operator +(dynamic addend) => Scalar.from(q + addend);
  Scalar operator -(dynamic subtrahend) => Scalar.from(q - subtrahend);
}

extension type Angle._(Quantity q) implements Quantity {
  Angle.from(this.q) : assert(q.dimensions == angle);
  const Angle.zero() : q = const Quantity(0, radian);
  Angle(num value, Unit unit) : this.from(Quantity(value, unit));
  Angle.degrees(num value) : this(value, degree);
  Angle.radians(num value) : this(value, radian);
  Angle operator +(Angle addend) => Angle.from(q + addend);
  Angle operator -(Angle subtrahend) => Angle.from(q - subtrahend);
}

extension type Length._(Quantity q) implements Quantity {
  Length.from(this.q) : assert(q.dimensions == length);
  const Length.zero() : q = const Quantity(0, metre);
  Length(num value, Unit unit) : this.from(Quantity(value, unit));
  Length.metres(num value) : this(value, metre);
  Length operator +(Length addend) => Length.from(q + addend);
  Length operator -(Length subtrahend) => Length.from(q - subtrahend);
}

extension type Mass._(Quantity q) implements Quantity {
  Mass.from(this.q) : assert(q.dimensions == mass);
  const Mass.zero() : q = const Quantity(0, kilogram);
  Mass(num value, Unit unit) : this.from(Quantity(value, unit));
  Mass.grams(num value) : this(value, gram);
  Mass.kilograms(num value) : this(value, kilogram);
  Mass operator +(Mass addend) => Mass.from(q + addend);
  Mass operator -(Mass subtrahend) => Mass.from(q - subtrahend);
}

extension type Area._(Quantity q) implements Quantity {
  Area.from(this.q) : assert(q.dimensions == area);
  const Area.zero() : q = const Quantity(0, squareMetre);
  Area(num value, Unit unit) : this.from(Quantity(value, unit));
  Area.squareMetres(num value) : this(value, squareMetre);
  Area.hectares(num value) : this(value, hectare);
  Area operator +(Area addend) => Area.from(q + addend);
  Area operator -(Area subtrahend) => Area.from(q - subtrahend);
  num toJson() => q.value;
}

extension type Volume._(Quantity q) implements Quantity {
  Volume.from(this.q) : assert(q.dimensions == volume);
  const Volume.zero() : q = const Quantity(0, cubicMetre);
  Volume(num value, Unit unit) : this.from(Quantity(value, unit));
  Volume.litres(num value) : this(value, litre);
  Volume.cubicMetres(num value) : this(value, cubicMetre);
  Volume operator +(Volume addend) => Volume.from(q + addend);
  Volume operator -(Volume subtrahend) => Volume.from(q - subtrahend);
  num toJson() => q.value;
}

extension type MassPerVolume._(Quantity q) implements Quantity {
  MassPerVolume.from(this.q) : assert(q.dimensions == massPerVolume);
  const MassPerVolume.zero() : q = const Quantity(0, kilogramPerCubicMetre);
  MassPerVolume(num value, Unit unit) : this.from(Quantity(value, unit));
  MassPerVolume.kilogramsPerCubicMetre(num value) : this(value, kilogram / cubicMetre);
  MassPerVolume.gramsPerCubicCentimetre(num value) : this(value, gram / (metre.centi ^ 3));
  MassPerVolume operator +(MassPerVolume addend) => MassPerVolume.from(q + addend);
  MassPerVolume operator -(MassPerVolume subtrahend) => MassPerVolume.from(q - subtrahend);
  num toJson() => q.value;
}

extension type VolumePerMass._(Quantity q) implements Quantity {
  VolumePerMass.from(this.q) : assert(q.dimensions == volumePerMass);
  const VolumePerMass.zero() : q = const Quantity(0, cubicMetrePerKilogram);
  VolumePerMass(num value, Unit unit) : this.from(Quantity(value, unit));
  VolumePerMass.cubicMetresPerKilogram(num value) : this(value, cubicMetre / kilogram);
  VolumePerMass operator +(VolumePerMass addend) => VolumePerMass.from(q + addend);
  VolumePerMass operator -(VolumePerMass subtrahend) => VolumePerMass.from(q - subtrahend);
  num toJson() => q.value;
}

extension type Time._(Quantity q) implements Quantity {
  Time.from(this.q) : assert(q.dimensions == time);
  const Time.zero() : q = const Quantity(0, second);
  Time(num value, Unit unit) : this.from(Quantity(value, unit));
  Time.microseconds(num value) : this(value, second.micro);
  Time.milliseconds(num value) : this(value, second.milli);
  Time.seconds(num value) : this(value, second);
  Time.minutes(num value) : this(value, minute);
  Time.hours(num value) : this(value, hour);
  Time.hms(int hours, int minutes, int seconds)
      : this.from(Time.hours(hours) + Time.minutes(minutes) + Time.seconds(seconds));
  Time.fromDuration(Duration duration) : this.microseconds(duration.inMicroseconds);
  Time operator +(Time addend) => Time.from(q + addend);
  Time operator -(Time subtrahend) => Time.from(q - subtrahend);
  num toJson() => q.value;
}

extension type Temperature._(QuantityPoint qp) implements QuantityPoint {
  Temperature.from(this.qp) : assert(qp.quantity.dimensions == temperature);
  Temperature(num value, Unit unit, QuantityOrigin origin) : this.from(QuantityPoint(Quantity(value, unit), origin));
  Temperature.degreesCelsius(num value) : this(value, degreeCelsius, zerothDegreeCelsius);
  Temperature.degreesFahrenheit(num value) : this(value, degreeFahrenheit, zerothDegreeFahrenheit);

  Temperature inDegreesCelsius() => Temperature.from(
        qp.withOrigin(zerothDegreeCelsius).inUnits(degreeCelsius),
      );
  Temperature inDegreesFahrenheit() => Temperature.from(
        qp.withOrigin(zerothDegreeFahrenheit).inUnits(degreeFahrenheit),
      );
}

extension type Speed._(Quantity q) implements Quantity {
  Speed.from(this.q) : assert(q.dimensions == speed);
  Speed(num value, Unit unit) : this.from(Quantity(value, unit));
  Speed.metresPerSecond(num value) : this(value, metrePerSecond);
  Speed operator +(Speed addend) => Speed.from(q + addend);
  Speed operator -(Speed subtrahend) => Speed.from(q - subtrahend);
}

extension type Capacitance._(Quantity q) implements Quantity {
  Capacitance.from(this.q) : assert(q.dimensions == capacitance);
  Capacitance(num value, Unit unit) : this.from(Quantity(value, unit));
  Capacitance.farads(num value) : this(value, farad);
  Capacitance operator +(Capacitance addend) => Capacitance.from(q + addend);
  Capacitance operator -(Capacitance subtrahend) => Capacitance.from(q - subtrahend);
}

extension type Frequency._(Quantity q) implements Quantity {
  Frequency.from(this.q) : assert(q.dimensions == frequency);
  const Frequency.zero() : q = const Quantity(0, hertz);
  Frequency(num value, Unit unit) : this.from(Quantity(value, unit));
  Frequency.hertz(num value) : this(value, hertz);
  Frequency operator +(Frequency addend) => Frequency.from(q + addend);
  Frequency operator -(Frequency subtrahend) => Frequency.from(q - subtrahend);
}

extension type Voltage._(Quantity q) implements Quantity {
  Voltage.from(this.q) : assert(q.dimensions == voltage);
  Voltage(num value, Unit unit) : this.from(Quantity(value, unit));
  Voltage operator +(Voltage addend) => Voltage.from(q + addend);
  Voltage operator -(Voltage subtrahend) => Voltage.from(q - subtrahend);
}

extension type MassPerTime._(Quantity q) implements Quantity {
  MassPerTime.from(this.q) : assert(q.dimensions == massPerTime);
  MassPerTime(num value, Unit unit) : this.from(Quantity(value, unit));
  MassPerTime.kilogramsPerSecond(num value) : this(value, kilogramPerSecond);
  MassPerTime operator +(MassPerTime addend) => MassPerTime.from(q + addend);
  MassPerTime operator -(MassPerTime subtrahend) => MassPerTime.from(q - subtrahend);
}

extension type MassPerArea._(Quantity q) implements Quantity {
  MassPerArea.from(this.q) : assert(q.dimensions == massPerArea);
  MassPerArea(num value, Unit unit) : this.from(Quantity(value, unit));
  MassPerArea.kilogramsPerSquareMetre(num value) : this(value, kilogramPerSquareMetre);
  MassPerArea operator +(MassPerArea addend) => MassPerArea.from(q + addend);
  MassPerArea operator -(MassPerArea subtrahend) => MassPerArea.from(q - subtrahend);
}

extension type VolumePerTime._(Quantity q) implements Quantity {
  VolumePerTime.from(this.q) : assert(q.dimensions == volumePerTime);
  VolumePerTime(num value, Unit unit) : this.from(Quantity(value, unit));
  VolumePerTime.cubicMetresPerSecond(num value) : this(value, cubicMetrePerSecond);
  VolumePerTime operator +(VolumePerTime addend) => VolumePerTime.from(q + addend);
  VolumePerTime operator -(VolumePerTime subtrahend) => VolumePerTime.from(q - subtrahend);
}

extension type VolumePerArea._(Quantity q) implements Quantity {
  VolumePerArea.from(this.q) : assert(q.dimensions == volumePerArea);
  VolumePerArea(num value, Unit unit) : this.from(Quantity(value, unit));
  VolumePerArea.cubicMetresPerSquareMetre(num value) : this(value, cubicMetrePerSquareMetre);
  VolumePerArea operator +(VolumePerArea addend) => VolumePerArea.from(q + addend);
  VolumePerArea operator -(VolumePerArea subtrahend) => VolumePerArea.from(q - subtrahend);
}
