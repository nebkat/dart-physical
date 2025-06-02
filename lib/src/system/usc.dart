import '../core/quantity.dart';
import '../core/unit.dart';
import '../common/dimensions.dart';
import 'si.dart';

const bushelUs = UnprefixableRealUnit(
    symbol: 'bu', singular: 'bushel (US)', plural: 'bushels (US)', dimensions: volume, scale: 0.03523907016688);
const degreeFahrenheit = DerivedUnit(
  symbol: '°F',
  singular: 'degree Fahrenheit',
  plural: 'degrees Fahrenheit',
  dimensions: temperature,
  scale: 5 / 9,
);
const zerothDegreeFahrenheit = QuantityOrigin(Quantity(2298.35 / 9, kelvin));

const ton = UnprefixableRealUnit(symbol: 'tn', singular: 'ton', plural: 'tons', dimensions: mass, scale: 907.18474);
