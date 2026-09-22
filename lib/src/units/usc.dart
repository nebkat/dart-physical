import '../common/dimensions.dart';
import '../core/quantity.dart';
import '../core/unit.dart';
import 'si.dart';

const bushel = NamedUnit(
  symbol: 'bu',
  singular: 'bushel (US)',
  plural: 'bushels (US)',
  dimensions: volume,
  scale: 0.03523907016688,
);
const degreeFahrenheit = OffsetUnit(
  symbol: '°F',
  singular: 'degree Fahrenheit',
  plural: 'degrees Fahrenheit',
  dimensions: temperature,
  scale: 5 / 9,
  spaceBeforeSymbol: false,
  implicitOrigin: zerothDegreeFahrenheit,
);
const zerothDegreeFahrenheit = QuantityOrigin(
  Quantity.of(2298.35 / 9, kelvin),
);

const ton = NamedUnit(
  symbol: 'tn',
  singular: 'ton',
  plural: 'tons',
  dimensions: mass,
  scale: 907.18474,
);
