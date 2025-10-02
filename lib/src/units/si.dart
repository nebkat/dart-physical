import 'dart:math';

import '../common/dimensions.dart';
import '../core/unit.dart';
import '../core/quantity.dart';

const second = SiNamedUnit(
  symbol: 's',
  singular: 'second',
  plural: 'seconds',
  dimensions: time,
  scale: 1,
);
const metre = SiNamedUnit(
  symbol: 'm',
  singular: 'metre',
  plural: 'metres',
  dimensions: length,
  scale: 1,
);
const gram = SiNamedUnit(
  symbol: 'g',
  singular: 'gram',
  plural: 'grams',
  dimensions: mass,
  scale: 0.001,
);
const kilogram = NamedUnit(
  symbol: 'kg',
  singular: 'kilogram',
  plural: 'kilograms',
  dimensions: mass,
  scale: 1,
);
const ampere = SiNamedUnit(
  symbol: 'A',
  singular: 'ampere',
  plural: 'amperes',
  dimensions: electricCurrent,
  scale: 1,
);
const kelvin = SiNamedUnit(
  symbol: 'K',
  singular: 'kelvin',
  plural: 'kelvin',
  dimensions: temperature,
  scale: 1,
);
const mole = SiNamedUnit(
  symbol: 'mol',
  singular: 'mole',
  plural: 'moles',
  dimensions: amountOfSubstance,
  scale: 1,
);
const candela = SiNamedUnit(
  symbol: 'cd',
  singular: 'candela',
  plural: 'candelas',
  dimensions: luminousIntensity,
  scale: 1,
);

const degreeCelsius = NamedUnit(
  symbol: '°C',
  singular: '',
  plural: '',
  dimensions: temperature,
  scale: 1,
  spaceBeforeSymbol: false,
);

const absoluteZeroKelvin = QuantityOrigin(Quantity.zero(kelvin));
const zerothDegreeCelsius = QuantityOrigin(Quantity.of(273.15, kelvin));

const radian = SiNamedUnit(
  symbol: 'rad',
  singular: 'radian',
  plural: 'radians',
  dimensions: angle,
  scale: 1,
);
const steradian = SiNamedUnit(
  symbol: 'sr',
  singular: 'steradian',
  plural: 'steradians',
  dimensions: solidAngle,
  scale: 1,
);
const hertz = SiNamedUnit(
  symbol: 'Hz',
  singular: 'hertz',
  plural: 'hertz',
  dimensions: frequency,
  scale: 1,
);
const newton = SiNamedUnit(
  symbol: 'N',
  singular: 'newton',
  plural: 'newtons',
  dimensions: force,
  scale: 1,
);
const pascal = SiNamedUnit(
  symbol: 'Pa',
  singular: 'pascal',
  plural: 'pascals',
  dimensions: pressure,
  scale: 1,
);
const joule = SiNamedUnit(
  symbol: 'J',
  singular: 'joule',
  plural: 'joules',
  dimensions: energy,
  scale: 1,
);
const watt = SiNamedUnit(
  symbol: 'W',
  singular: 'watt',
  plural: 'watts',
  dimensions: power,
  scale: 1,
);
const coulomb = SiNamedUnit(
  symbol: 'C',
  singular: 'coulomb',
  plural: 'coulombs',
  dimensions: electricCharge,
  scale: 1,
);
const volt = SiNamedUnit(
  symbol: 'V',
  singular: 'volt',
  plural: 'volts',
  dimensions: electricPotential,
  scale: 1,
);
const farad = SiNamedUnit(
  symbol: 'F',
  singular: 'farad',
  plural: 'farads',
  dimensions: capacitance,
  scale: 1,
);
const ohm = SiNamedUnit(
  symbol: 'Ω',
  singular: 'ohm',
  plural: 'ohms',
  dimensions: resistance,
  scale: 1,
);
const siemens = SiNamedUnit(
  symbol: 'S',
  singular: 'siemens',
  plural: 'siemens',
  dimensions: conductance,
  scale: 1,
);
const henry = SiNamedUnit(
  symbol: 'H',
  singular: 'henry',
  plural: 'henries',
  dimensions: inductance,
  scale: 1,
);
const weber = SiNamedUnit(
  symbol: 'Wb',
  singular: 'weber',
  plural: 'webers',
  dimensions: magneticFlux,
  scale: 1,
);
const tesla = SiNamedUnit(
  symbol: 'T',
  singular: 'tesla',
  plural: 'teslas',
  dimensions: magneticFluxDensity,
  scale: 1,
);

const lumen = SiNamedUnit(
  symbol: 'lm',
  singular: 'lumen',
  plural: 'lumens',
  dimensions: luminousFlux,
  scale: 1,
);
const lux = SiNamedUnit(
  symbol: 'lx',
  singular: 'lux',
  plural: 'lux',
  dimensions: illuminance,
  scale: 1,
);

// Non-SI units
const minute = SiNamedUnit(
  symbol: 'min',
  singular: 'minute',
  plural: 'minutes',
  dimensions: time,
  scale: 60,
);
const hour = SiNamedUnit(
  symbol: 'h',
  singular: 'hour',
  plural: 'hours',
  dimensions: time,
  scale: 3600,
);
const day = SiNamedUnit(
  symbol: 'd',
  singular: 'day',
  plural: 'days',
  dimensions: time,
  scale: 86400,
);

const degree = SiNamedUnit(
  symbol: '°',
  singular: 'degree',
  plural: 'degrees',
  dimensions: angle,
  scale: pi / 180,
  spaceBeforeSymbol: false,
);
const arcminute = SiNamedUnit(
  symbol: '′',
  singular: 'arcminute',
  plural: 'arcminutes',
  dimensions: angle,
  scale: pi / (180 * 60),
  spaceBeforeSymbol: false,
);
const arcsecond = SiNamedUnit(
  symbol: '″',
  singular: 'arcsecond',
  plural: 'arcseconds',
  dimensions: angle,
  scale: pi / (180 * 3600),
  spaceBeforeSymbol: false,
);

const are = SiNamedUnit(
  symbol: 'a',
  singular: 'are',
  plural: 'ares',
  dimensions: area,
  scale: 100,
);
const hectare = NamedUnit(
  symbol: 'ha',
  singular: 'hectare',
  plural: 'hectares',
  dimensions: area,
  scale: 10000,
);

const litre = SiNamedUnit(
  symbol: 'L',
  singular: 'litre',
  plural: 'litres',
  dimensions: volume,
  scale: 0.001,
);
const tonne = SiNamedUnit(
  symbol: 't',
  singular: 'tonne',
  plural: 'tonnes',
  dimensions: mass,
  scale: 1000,
);

// Derived units
const metrePerSecond = DerivedUnit(
  symbol: 'm/s',
  singular: 'metre per second',
  plural: 'metres per second',
  dimensions: speed,
  scale: 1,
);
const kilometrePerHour = DerivedUnit(
  symbol: 'km/h',
  singular: 'kilometre per hour',
  plural: 'kilometres per hour',
  dimensions: speed,
  scale: 1 / 3.6,
);

const metrePerSecondSquared = DerivedUnit(
  symbol: 'm/s²',
  singular: 'metre per second squared',
  plural: 'metres per second squared',
  dimensions: acceleration,
  scale: 1,
);

const squareMetre = DerivedUnit(
  symbol: 'm²',
  singular: 'metre squared',
  plural: 'metres squared',
  dimensions: area,
  scale: 1,
);
const cubicMetre = DerivedUnit(
  symbol: 'm³',
  singular: 'metre cubed',
  plural: 'metres cubed',
  dimensions: volume,
  scale: 1,
);

const cubicMetrePerKilogram = DerivedUnit(
  symbol: 'm³/kg',
  singular: 'metre cubed per kilogram',
  plural: 'metres cubed per kilogram',
  dimensions: volumePerMass,
  scale: 1,
);
const cubicMetrePerSecond = DerivedUnit(
  symbol: 'm³/s',
  singular: 'metre cubed per second',
  plural: 'metres cubed per second',
  dimensions: volumePerTime,
  scale: 1,
);
const cubicMetrePerSquareMetre = DerivedUnit(
  symbol: 'm³/m²',
  singular: 'metre cubed per metre squared',
  plural: 'metres cubed per metre squared',
  dimensions: volumePerArea,
  scale: 1,
);

const kilogramPerSecond = DerivedUnit(
  symbol: 'kg/s',
  singular: 'kilogram per second',
  plural: 'kilograms per second',
  dimensions: massPerTime,
  scale: 1,
);
const kilogramPerSquareMetre = DerivedUnit(
  symbol: 'kg/m²',
  singular: 'kilogram per metre squared',
  plural: 'kilograms per metre squared',
  dimensions: massPerArea,
  scale: 1,
);
const kilogramPerCubicMetre = DerivedUnit(
  symbol: 'kg/m³',
  singular: 'kilogram per metre cubed',
  plural: 'kilograms per metre cubed',
  dimensions: massPerVolume,
  scale: 1,
);

const wattHour = DerivedUnit(
  symbol: 'Wh',
  singular: 'watt hour',
  plural: 'watt hours',
  dimensions: energy,
  scale: 3600,
);
