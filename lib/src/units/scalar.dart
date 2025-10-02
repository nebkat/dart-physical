import '../common/dimensions.dart';
import '../core/unit.dart';

const Unit one = Unit.one;

const percent = DerivedUnit(
  symbol: '%',
  singular: 'percent',
  plural: 'percent',
  dimensions: dimensionless,
  scale: 0.01,
  spaceBeforeSymbol: false,
);
const perMille = DerivedUnit(
  symbol: '‰',
  singular: 'per mille',
  plural: 'per mille',
  dimensions: dimensionless,
  scale: 0.001,
  spaceBeforeSymbol: false,
);
const partsPerMillion = DerivedUnit(
  symbol: 'ppm',
  singular: 'part per million',
  plural: 'parts per million',
  dimensions: dimensionless,
  scale: 1e-6,
);
const partsPerBillion = DerivedUnit(
  symbol: 'ppb',
  singular: 'part per billion',
  plural: 'parts per billion',
  dimensions: dimensionless,
  scale: 1e-9,
);
