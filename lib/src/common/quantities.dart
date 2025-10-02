import '../core/quantity.dart';
import '../core/unit.dart';
import '../units/si.dart' as si;
import '../units/usc.dart' as usc show degreeFahrenheit, zerothDegreeFahrenheit;
import 'dimensions.dart';

extension type Angle._(Quantity q) implements DimensionedQuantity<Angle> {
  Angle(Quantity q) : q = angle.checked(q);
  const Angle.zero() : q = const Quantity.of(0, si.radian);
  Angle.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Angle.degrees(num value) : this._(Quantity.of(value, si.degree));
  Angle.radians(num value) : this._(Quantity.of(value, si.radian));
}

extension type Length._(Quantity q) implements DimensionedQuantity<Length> {
  Length(Quantity q) : q = length.checked(q);
  const Length.zero() : q = const Quantity.of(0, si.metre);
  Length.of(num value, Unit unit) : this._(Quantity.of(value, unit));
  Length.metres(num value) : this._(Quantity.of(value, si.metre));
}

extension type Mass._(Quantity q) implements DimensionedQuantity<Mass> {
  Mass(Quantity q) : q = mass.checked(q);
  const Mass.zero() : q = const Quantity.of(0, si.kilogram);
  Mass.of(num value, Unit unit) : this._(Quantity.of(value, unit));
  Mass.grams(num value) : this._(Quantity.of(value, si.gram));
  Mass.kilograms(num value) : this._(Quantity.of(value, si.kilogram));
}

extension type Area._(Quantity q) implements DimensionedQuantity<Area> {
  Area(Quantity q) : q = area.checked(q);
  const Area.zero() : q = const Quantity.of(0, si.squareMetre);
  Area.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Area.squareMetres(num value) : this._(Quantity.of(value, si.squareMetre));
  Area.hectares(num value) : this._(Quantity.of(value, si.hectare));
}

extension type Volume._(Quantity q) implements DimensionedQuantity<Volume> {
  Volume(Quantity q) : q = volume.checked(q);
  const Volume.zero() : q = const Quantity.of(0, si.cubicMetre);
  Volume.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Volume.litres(num value) : this._(Quantity.of(value, si.litre));
  Volume.cubicMetres(num value) : this._(Quantity.of(value, si.cubicMetre));
}

extension type MassPerVolume._(Quantity q) implements DimensionedQuantity<MassPerVolume> {
  MassPerVolume(Quantity q) : q = massPerVolume.checked(q);
  const MassPerVolume.zero() : q = const Quantity.of(0, si.kilogramPerCubicMetre);
  MassPerVolume.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerVolume.kilogramsPerCubicMetre(num value) : this._(Quantity.of(value, si.kilogram / si.cubicMetre));
  MassPerVolume.gramsPerCubicCentimetre(num value) : this._(Quantity.of(value, si.gram / (si.metre.centi ^ 3)));
}

extension type VolumePerMass._(Quantity q) implements DimensionedQuantity<VolumePerMass> {
  VolumePerMass(Quantity q) : q = volumePerMass.checked(q);
  const VolumePerMass.zero() : q = const Quantity.of(0, si.cubicMetrePerKilogram);
  VolumePerMass.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerMass.cubicMetresPerKilogram(num value) : this._(Quantity.of(value, si.cubicMetre / si.kilogram));
}

extension type Time._(Quantity q) implements DimensionedQuantity<Time> {
  Time(Quantity q) : q = time.checked(q);
  const Time.zero() : q = const Quantity.of(0, si.second);
  Time.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Time.microseconds(num value) : this._(Quantity.of(value, si.second.micro));
  Time.milliseconds(num value) : this._(Quantity.of(value, si.second.milli));
  Time.seconds(num value) : this._(Quantity.of(value, si.second));
  Time.minutes(num value) : this._(Quantity.of(value, si.minute));
  Time.hours(num value) : this._(Quantity.of(value, si.hour));
  Time.hms(int hours, int minutes, int seconds)
      : this(Time.hours(hours) + Time.minutes(minutes) + Time.seconds(seconds));
  Time.duration(Duration duration) : this.microseconds(duration.inMicroseconds);
}

extension type Temperature._(QuantityPoint qp) implements QuantityPoint {
  Temperature(this.qp) : assert(qp.quantity.dimensions == temperature, "${qp.quantity.dimensions} != $temperature");
  const Temperature.absoluteZero() : qp = const QuantityPoint(Quantity.of(0, si.kelvin), si.absoluteZeroKelvin);
  const Temperature.icePoint() : qp = const QuantityPoint(Quantity.of(0, si.degreeCelsius), si.zerothDegreeCelsius);
  Temperature.of(num value, Unit unit, QuantityOrigin origin) : this(origin + Quantity.of(value, unit));
  Temperature.kelvins(num value) : this._(si.absoluteZeroKelvin + Quantity.of(value, si.kelvin));
  Temperature.degreesCelsius(num value) : this._(si.zerothDegreeCelsius + Quantity.of(value, si.degreeCelsius));
  Temperature.degreesFahrenheit(num value)
      : this._(usc.zerothDegreeFahrenheit + Quantity.of(value, usc.degreeFahrenheit));

  Temperature inDegreesCelsius() => Temperature(
        qp.withOrigin(si.zerothDegreeCelsius).inUnits(si.degreeCelsius),
      );
  Temperature inDegreesFahrenheit() => Temperature(
        qp.withOrigin(usc.zerothDegreeFahrenheit).inUnits(usc.degreeFahrenheit),
      );
}

extension type Speed._(Quantity q) implements DimensionedQuantity<Speed> {
  Speed(Quantity q) : q = speed.checked(q);
  const Speed.zero() : q = const Quantity.of(0, si.metrePerSecond);
  Speed.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Speed.metresPerSecond(num value) : this._(Quantity.of(value, si.metrePerSecond));
}

extension type Acceleration._(Quantity q) implements DimensionedQuantity<Acceleration> {
  Acceleration(Quantity q) : q = acceleration.checked(q);
  const Acceleration.zero() : q = const Quantity.of(0, si.metrePerSecondSquared);
  Acceleration.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Acceleration.metresPerSecondSquared(num value) : this._(Quantity.of(value, si.metrePerSecondSquared));
}

extension type Capacitance._(Quantity q) implements DimensionedQuantity<Capacitance> {
  Capacitance(Quantity q) : q = capacitance.checked(q);
  const Capacitance.zero() : q = const Quantity.of(0, si.farad);
  Capacitance.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Capacitance.farads(num value) : this._(Quantity.of(value, si.farad));
}

extension type Frequency._(Quantity q) implements DimensionedQuantity<Frequency> {
  Frequency(Quantity q) : q = frequency.checked(q);
  const Frequency.zero() : q = const Quantity.of(0, si.hertz);
  Frequency.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Frequency.hertz(num value) : this._(Quantity.of(value, si.hertz));
}

extension type Voltage._(Quantity q) implements DimensionedQuantity<Voltage> {
  Voltage(Quantity q) : q = voltage.checked(q);
  const Voltage.zero() : q = const Quantity.of(0, si.volt);
  Voltage.of(num value, Unit unit) : this(Quantity.of(value, unit));
}

extension type Current._(Quantity q) implements DimensionedQuantity<Current> {
  Current(Quantity q) : q = electricCurrent.checked(q);
  const Current.zero() : q = const Quantity.of(0, si.ampere);
  Current.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Current.amperes(num value) : this._(Quantity.of(value, si.ampere));
}

extension type Resistance._(Quantity q) implements DimensionedQuantity<Resistance> {
  Resistance(Quantity q) : q = resistance.checked(q);
  const Resistance.zero() : q = const Quantity.of(0, si.ohm);
  Resistance.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Resistance.ohms(num value) : this._(Quantity.of(value, si.ohm));
}

extension type Power._(Quantity q) implements DimensionedQuantity<Power> {
  Power(Quantity q) : q = power.checked(q);
  const Power.zero() : q = const Quantity.of(0, si.watt);
  Power.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Power.watts(num value) : this._(Quantity.of(value, si.watt));
}

extension type Energy._(Quantity q) implements DimensionedQuantity<Energy> {
  Energy(Quantity q) : q = energy.checked(q);
  const Energy.zero() : q = const Quantity.of(0, si.joule);
  Energy.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Energy.joules(num value) : this._(Quantity.of(value, si.joule));
  Energy.wattHours(num value) : this._(Quantity.of(value, si.wattHour));
}

extension type MassPerTime._(Quantity q) implements DimensionedQuantity<MassPerTime> {
  MassPerTime(Quantity q) : q = massPerTime.checked(q);
  const MassPerTime.zero() : q = const Quantity.of(0, si.kilogramPerSecond);
  MassPerTime.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerTime.kilogramsPerSecond(num value) : this._(Quantity.of(value, si.kilogramPerSecond));
}

extension type MassPerArea._(Quantity q) implements DimensionedQuantity<MassPerArea> {
  MassPerArea(Quantity q) : q = massPerArea.checked(q);
  const MassPerArea.zero() : q = const Quantity.of(0, si.kilogramPerSquareMetre);
  MassPerArea.of(num value, Unit unit) : this(Quantity.of(value, unit));
  MassPerArea.kilogramsPerSquareMetre(num value) : this._(Quantity.of(value, si.kilogramPerSquareMetre));
}

extension type VolumePerTime._(Quantity q) implements DimensionedQuantity<VolumePerTime> {
  VolumePerTime(Quantity q) : q = volumePerTime.checked(q);
  const VolumePerTime.zero() : q = const Quantity.of(0, si.cubicMetrePerSecond);
  VolumePerTime.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerTime.cubicMetresPerSecond(num value) : this._(Quantity.of(value, si.cubicMetrePerSecond));
}

extension type VolumePerArea._(Quantity q) implements DimensionedQuantity<VolumePerArea> {
  VolumePerArea(Quantity q) : q = volumePerArea.checked(q);
  const VolumePerArea.zero() : q = const Quantity.of(0, si.cubicMetrePerSquareMetre);
  VolumePerArea.of(num value, Unit unit) : this(Quantity.of(value, unit));
  VolumePerArea.cubicMetresPerSquareMetre(num value) : this._(Quantity.of(value, si.cubicMetrePerSquareMetre));
}
