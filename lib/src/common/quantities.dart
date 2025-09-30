import '../core/quantity.dart';
import '../core/unit.dart';
import '../system/si.dart';
import '../system/usc.dart';
import 'dimensions.dart';

extension type Angle._(Quantity q) implements DimensionedQuantity<Angle> {
  Angle(Quantity q) : q = angle.checked(q);
  const Angle.zero() : q = const Quantity.of(0, radian);
  Angle.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Angle.degrees(num value) : this._(Quantity.of(value, degree));
  Angle.radians(num value) : this._(Quantity.of(value, radian));
}

extension type Length._(Quantity q) implements DimensionedQuantity<Length> {
  Length(Quantity q) : q = length.checked(q);
  const Length.zero() : q = const Quantity.of(0, metre);
  Length.of(num value, Unit unit) : this._(Quantity.of(value, unit));
  Length.metres(num value) : this._(Quantity.of(value, metre));
}

extension type Mass._(Quantity q) implements DimensionedQuantity<Mass> {
  Mass(Quantity q) : q = mass.checked(q);
  const Mass.zero() : q = const Quantity.of(0, kilogram);
  Mass.of(num value, Unit unit) : this._(Quantity.of(value, unit));
  Mass.grams(num value) : this._(Quantity.of(value, gram));
  Mass.kilograms(num value) : this._(Quantity.of(value, kilogram));
}

extension type Area._(Quantity q) implements DimensionedQuantity<Area> {
  Area(Quantity q) : q = area.checked(q);
  const Area.zero() : q = const Quantity.of(0, squareMetre);
  Area.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Area.squareMetres(num value) : this._(Quantity.of(value, squareMetre));
  Area.hectares(num value) : this._(Quantity.of(value, hectare));
}

extension type Volume._(Quantity q) implements DimensionedQuantity<Volume> {
  Volume(Quantity q) : q = volume.checked(q);
  const Volume.zero() : q = const Quantity.of(0, cubicMetre);
  Volume.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Volume.litres(num value) : this._(Quantity.of(value, litre));
  Volume.cubicMetres(num value) : this._(Quantity.of(value, cubicMetre));
}

extension type MassPerVolume._(Quantity q) implements DimensionedQuantity<MassPerVolume> {
  MassPerVolume(Quantity q) : q = massPerVolume.checked(q);
  const MassPerVolume.zero() : q = const Quantity.of(0, kilogramPerCubicMetre);
  MassPerVolume.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerVolume.kilogramsPerCubicMetre(num value) : this._(Quantity.of(value, kilogram / cubicMetre));
  MassPerVolume.gramsPerCubicCentimetre(num value) : this._(Quantity.of(value, gram / (metre.centi ^ 3)));
}

extension type VolumePerMass._(Quantity q) implements DimensionedQuantity<VolumePerMass> {
  VolumePerMass(Quantity q) : q = volumePerMass.checked(q);
  const VolumePerMass.zero() : q = const Quantity.of(0, cubicMetrePerKilogram);
  VolumePerMass.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerMass.cubicMetresPerKilogram(num value) : this._(Quantity.of(value, cubicMetre / kilogram));
}

extension type Time._(Quantity q) implements DimensionedQuantity<Time> {
  Time(Quantity q) : q = time.checked(q);
  const Time.zero() : q = const Quantity.of(0, second);
  Time.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Time.microseconds(num value) : this._(Quantity.of(value, second.micro));
  Time.milliseconds(num value) : this._(Quantity.of(value, second.milli));
  Time.seconds(num value) : this._(Quantity.of(value, second));
  Time.minutes(num value) : this._(Quantity.of(value, minute));
  Time.hours(num value) : this._(Quantity.of(value, hour));
  Time.hms(int hours, int minutes, int seconds)
      : this(Time.hours(hours) + Time.minutes(minutes) + Time.seconds(seconds));
  Time.duration(Duration duration) : this.microseconds(duration.inMicroseconds);
}

extension type Temperature._(QuantityPoint qp) implements QuantityPoint {
  Temperature(this.qp) : assert(qp.quantity.dimensions == temperature, "${qp.quantity.dimensions} != $temperature");
  const Temperature.absoluteZero() : qp = const QuantityPoint(Quantity.of(0, kelvin), absoluteZeroKelvin);
  const Temperature.icePoint() : qp = const QuantityPoint(Quantity.of(0, degreeCelsius), zerothDegreeCelsius);
  Temperature.of(num value, Unit unit, QuantityOrigin origin) : this(origin + Quantity.of(value, unit));
  Temperature.kelvins(num value) : this._(absoluteZeroKelvin + Quantity.of(value, kelvin));
  Temperature.degreesCelsius(num value) : this._(zerothDegreeCelsius + Quantity.of(value, degreeCelsius));
  Temperature.degreesFahrenheit(num value) : this._(zerothDegreeFahrenheit + Quantity.of(value, degreeFahrenheit));

  Temperature inDegreesCelsius() => Temperature(
        qp.withOrigin(zerothDegreeCelsius).inUnits(degreeCelsius),
      );
  Temperature inDegreesFahrenheit() => Temperature(
        qp.withOrigin(zerothDegreeFahrenheit).inUnits(degreeFahrenheit),
      );
}

extension type Speed._(Quantity q) implements DimensionedQuantity<Speed> {
  Speed(Quantity q) : q = speed.checked(q);
  const Speed.zero() : q = const Quantity.of(0, metrePerSecond);
  Speed.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Speed.metresPerSecond(num value) : this._(Quantity.of(value, metrePerSecond));
}

extension type Acceleration._(Quantity q) implements DimensionedQuantity<Acceleration> {
  Acceleration(Quantity q) : q = acceleration.checked(q);
  const Acceleration.zero() : q = const Quantity.of(0, metrePerSecondSquared);
  Acceleration.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Acceleration.metresPerSecondSquared(num value) : this._(Quantity.of(value, metrePerSecondSquared));
}

extension type Capacitance._(Quantity q) implements DimensionedQuantity<Capacitance> {
  Capacitance(Quantity q) : q = capacitance.checked(q);
  const Capacitance.zero() : q = const Quantity.of(0, farad);
  Capacitance.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Capacitance.farads(num value) : this._(Quantity.of(value, farad));
}

extension type Frequency._(Quantity q) implements DimensionedQuantity<Frequency> {
  Frequency(Quantity q) : q = frequency.checked(q);
  const Frequency.zero() : q = const Quantity.of(0, hertz);
  Frequency.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Frequency.hertz(num value) : this._(Quantity.of(value, hertz));
}

extension type Voltage._(Quantity q) implements DimensionedQuantity<Voltage> {
  Voltage(Quantity q) : q = voltage.checked(q);
  const Voltage.zero() : q = const Quantity.of(0, volt);
  Voltage.of(num value, Unit unit) : this(Quantity.of(value, unit));
}

extension type Current._(Quantity q) implements DimensionedQuantity<Current> {
  Current(Quantity q) : q = electricCurrent.checked(q);
  const Current.zero() : q = const Quantity.of(0, ampere);
  Current.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Current.amperes(num value) : this._(Quantity.of(value, ampere));
}

extension type Resistance._(Quantity q) implements DimensionedQuantity<Resistance> {
  Resistance(Quantity q) : q = resistance.checked(q);
  const Resistance.zero() : q = const Quantity.of(0, ohm);
  Resistance.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Resistance.ohms(num value) : this._(Quantity.of(value, ohm));
}

extension type Power._(Quantity q) implements DimensionedQuantity<Power> {
  Power(Quantity q) : q = power.checked(q);
  const Power.zero() : q = const Quantity.of(0, watt);
  Power.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Power.watts(num value) : this._(Quantity.of(value, watt));
}

extension type Energy._(Quantity q) implements DimensionedQuantity<Energy> {
  Energy(Quantity q) : q = energy.checked(q);
  const Energy.zero() : q = const Quantity.of(0, joule);
  Energy.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Energy.joules(num value) : this._(Quantity.of(value, joule));
  Energy.wattHours(num value) : this._(Quantity.of(value, wattHour));
}

extension type MassPerTime._(Quantity q) implements DimensionedQuantity<MassPerTime> {
  MassPerTime(Quantity q) : q = massPerTime.checked(q);
  const MassPerTime.zero() : q = const Quantity.of(0, kilogramPerSecond);
  MassPerTime.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerTime.kilogramsPerSecond(num value) : this._(Quantity.of(value, kilogramPerSecond));
}

extension type MassPerArea._(Quantity q) implements DimensionedQuantity<MassPerArea> {
  MassPerArea(Quantity q) : q = massPerArea.checked(q);
  const MassPerArea.zero() : q = const Quantity.of(0, kilogramPerSquareMetre);
  MassPerArea.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerArea.kilogramsPerSquareMetre(num value) : this._(Quantity.of(value, kilogramPerSquareMetre));
}

extension type VolumePerTime._(Quantity q) implements DimensionedQuantity<VolumePerTime> {
  VolumePerTime(Quantity q) : q = volumePerTime.checked(q);
  const VolumePerTime.zero() : q = const Quantity.of(0, cubicMetrePerSecond);
  VolumePerTime.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerTime.cubicMetresPerSecond(num value) : this._(Quantity.of(value, cubicMetrePerSecond));
}

extension type VolumePerArea._(Quantity q) implements DimensionedQuantity<VolumePerArea> {
  VolumePerArea(Quantity q) : q = volumePerArea.checked(q);
  const VolumePerArea.zero() : q = const Quantity.of(0, cubicMetrePerSquareMetre);
  VolumePerArea.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerArea.cubicMetresPerSquareMetre(num value) : this._(Quantity.of(value, cubicMetrePerSquareMetre));
}
