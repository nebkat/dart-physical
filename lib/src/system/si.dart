import 'dart:math';

import '../common/dimensions.dart';
import '../core/unit.dart';
import '../core/quantity.dart';

const absoluteZeroKelvin = QuantityOrigin(Quantity(0, AnonymousUnit(dimensions: temperature)));

const second = RealUnit(
  symbol: 's',
  singular: 'second',
  plural: 'seconds',
  dimensions: time,
  scale: 1,
);
const metre = RealUnit(
  symbol: 'm',
  singular: 'metre',
  plural: 'metres',
  dimensions: length,
  scale: 1,
);
const gram = RealUnit(
  symbol: 'g',
  singular: 'gram',
  plural: 'grams',
  dimensions: mass,
  scale: 0.001,
);
const kilogram = PrefixedRealUnit(
  symbol: 'kg',
  singular: 'kilogram',
  plural: 'kilograms',
  dimensions: mass,
  scale: 1,
);
const ampere = RealUnit(
  symbol: 'A',
  singular: 'ampere',
  plural: 'amperes',
  dimensions: electricCurrent,
  scale: 1,
);
const kelvin = RealUnit(
  symbol: 'K',
  singular: 'kelvin',
  plural: 'kelvin',
  dimensions: temperature,
  scale: 1,
  implicitOrigin: absoluteZeroKelvin,
);
const mole = RealUnit(
  symbol: 'mol',
  singular: 'mole',
  plural: 'moles',
  dimensions: amountOfSubstance,
  scale: 1,
);
const candela = RealUnit(
  symbol: 'cd',
  singular: 'candela',
  plural: 'candelas',
  dimensions: luminousIntensity,
  scale: 1,
);

const degreeCelsius = PrefixedRealUnit(
  symbol: '°C',
  singular: '',
  plural: '',
  dimensions: temperature,
  scale: 1,
  implicitOrigin: zerothDegreeCelsius,
);
const zerothDegreeCelsius = QuantityOrigin(Quantity(273.15, kelvin));

const radian = RealUnit(symbol: 'rad', singular: 'radian', plural: 'radians', dimensions: angle, scale: 1);
const steradian = RealUnit(symbol: 'sr', singular: 'steradian', plural: 'steradians', dimensions: solidAngle, scale: 1);
const hertz = RealUnit(symbol: 'Hz', singular: 'hertz', plural: 'hertz', dimensions: frequency, scale: 1);
const newton = RealUnit(symbol: 'N', singular: 'newton', plural: 'newtons', dimensions: force, scale: 1);
const pascal = RealUnit(symbol: 'Pa', singular: 'pascal', plural: 'pascals', dimensions: pressure, scale: 1);
const joule = RealUnit(symbol: 'J', singular: 'joule', plural: 'joules', dimensions: energy, scale: 1);
const watt = RealUnit(symbol: 'W', singular: 'watt', plural: 'watts', dimensions: power, scale: 1);
const coulomb = RealUnit(symbol: 'C', singular: 'coulomb', plural: 'coulombs', dimensions: electricCharge, scale: 1);
const volt = RealUnit(symbol: 'V', singular: 'volt', plural: 'volts', dimensions: electricPotential, scale: 1);
const farad = RealUnit(symbol: 'F', singular: 'farad', plural: 'farads', dimensions: capacitance, scale: 1);
const ohm = RealUnit(symbol: 'Ω', singular: 'ohm', plural: 'ohms', dimensions: resistance, scale: 1);
const siemens = RealUnit(symbol: 'S', singular: 'siemens', plural: 'siemens', dimensions: conductance, scale: 1);
const henry = RealUnit(symbol: 'H', singular: 'henry', plural: 'henries', dimensions: inductance, scale: 1);
const weber = RealUnit(symbol: 'Wb', singular: 'weber', plural: 'webers', dimensions: magneticFlux, scale: 1);
const tesla = RealUnit(symbol: 'T', singular: 'tesla', plural: 'teslas', dimensions: magneticFluxDensity, scale: 1);

const lumen = RealUnit(symbol: 'lm', singular: 'lumen', plural: 'lumens', dimensions: luminousFlux, scale: 1);
const lux = RealUnit(symbol: 'lx', singular: 'lux', plural: 'lux', dimensions: illuminance, scale: 1);

// Non-SI units
const percent =
    DerivedUnit(symbol: '%', singular: 'percent', plural: 'percent', dimensions: dimensionless, scale: 0.01);
const perMille =
    DerivedUnit(symbol: '‰', singular: 'per mille', plural: 'per mille', dimensions: dimensionless, scale: 0.001);
const partsPerMillion = DerivedUnit(
    symbol: 'ppm', singular: 'part per million', plural: 'parts per million', dimensions: dimensionless, scale: 1e-6);
const partsPerBillion = DerivedUnit(
    symbol: 'ppb', singular: 'part per billion', plural: 'parts per billion', dimensions: dimensionless, scale: 1e-9);

const minute = RealUnit(symbol: 'min', singular: 'minute', plural: 'minutes', dimensions: time, scale: 60);
const hour = RealUnit(symbol: 'h', singular: 'hour', plural: 'hours', dimensions: time, scale: 3600);
const day = RealUnit(symbol: 'd', singular: 'day', plural: 'days', dimensions: time, scale: 86400);

const degree = RealUnit(
    symbol: '°', singular: 'degree', plural: 'degrees', dimensions: angle, scale: pi / 180, spaceBeforeSymbol: false);
const arcminute = RealUnit(
    symbol: '′',
    singular: 'arcminute',
    plural: 'arcminutes',
    dimensions: angle,
    scale: pi / (180 * 60),
    spaceBeforeSymbol: false);
const arcsecond = RealUnit(
    symbol: '″',
    singular: 'arcsecond',
    plural: 'arcseconds',
    dimensions: angle,
    scale: pi / (180 * 3600),
    spaceBeforeSymbol: false);

const are = RealUnit(symbol: 'a', singular: 'are', plural: 'ares', dimensions: area, scale: 100);
const hectare = PrefixedRealUnit(symbol: 'ha', singular: 'hectare', plural: 'hectares', dimensions: area, scale: 10000);

const litre = RealUnit(symbol: 'L', singular: 'litre', plural: 'litres', dimensions: volume, scale: 0.001);
const tonne = RealUnit(symbol: 't', singular: 'tonne', plural: 'tonnes', dimensions: mass, scale: 1000);

// Derived units
const metrePerSecond =
    DerivedUnit(symbol: 'm/s', singular: 'metre per second', plural: 'metres per second', dimensions: speed, scale: 1);
const kilometrePerHour = DerivedUnit(
    symbol: 'km/h', singular: 'kilometre per hour', plural: 'kilometres per hour', dimensions: speed, scale: 1 / 3.6);

const squareMetre =
    DerivedUnit(symbol: 'm²', singular: 'metre squared', plural: 'metres squared', dimensions: area, scale: 1);
const cubicMetre =
    DerivedUnit(symbol: 'm³', singular: 'metre cubed', plural: 'metres cubed', dimensions: volume, scale: 1);

const cubicMetrePerKilogram = DerivedUnit(
    symbol: 'm³/kg',
    singular: 'metre cubed per kilogram',
    plural: 'metres cubed per kilogram',
    dimensions: volumePerMass,
    scale: 1);
const cubicMetrePerSecond = DerivedUnit(
    symbol: 'm³/s',
    singular: 'metre cubed per second',
    plural: 'metres cubed per second',
    dimensions: volumePerTime,
    scale: 1);
const cubicMetrePerSquareMetre = DerivedUnit(
    symbol: 'm³/m²',
    singular: 'metre cubed per metre squared',
    plural: 'metres cubed per metre squared',
    dimensions: volumePerArea,
    scale: 1);

const kilogramPerSecond = DerivedUnit(
    symbol: 'kg/s', singular: 'kilogram per second', plural: 'kilograms per second', dimensions: massPerTime, scale: 1);
const kilogramPerSquareMetre = DerivedUnit(
    symbol: 'kg/m²',
    singular: 'kilogram per metre squared',
    plural: 'kilograms per metre squared',
    dimensions: massPerArea,
    scale: 1);
const kilogramPerCubicMetre = DerivedUnit(
    symbol: 'kg/m³',
    singular: 'kilogram per metre cubed',
    plural: 'kilograms per metre cubed',
    dimensions: massPerVolume,
    scale: 1);
