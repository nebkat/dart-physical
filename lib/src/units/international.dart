import '../core/unit.dart';
import '../common/dimensions.dart';

// Mass
const pound = NamedUnit(
  symbol: "lb",
  singular: 'pound',
  plural: 'pounds',
  dimensions: mass,
  scale: 45359237 / 100000000,
);
const ounce = NamedUnit(
  symbol: "oz",
  singular: 'ounce',
  plural: 'ounces',
  dimensions: mass,
  scale: 45359237 / 1600000000,
);
const dram = NamedUnit(
  symbol: "dr",
  singular: 'dram',
  plural: 'drams',
  dimensions: mass,
  scale: 45359237 / 25600000000,
);
const grain = NamedUnit(
  symbol: "gr",
  singular: 'grain',
  plural: 'grains',
  dimensions: mass,
  scale: 45359237 / 700000000000,
);

// Length
// https://en.wikipedia.org/wiki/United_States_customary_units#Length
const yard = NamedUnit(
  symbol: "yd",
  singular: 'yard',
  plural: 'yards',
  dimensions: length,
  scale: 9144 / 10000,
);
const foot = NamedUnit(
  symbol: "ft",
  singular: 'foot',
  plural: 'feet',
  dimensions: length,
  scale: 9144 / 30000,
);
const inch = NamedUnit(
  symbol: "in",
  singular: 'inch',
  plural: 'inches',
  dimensions: length,
  scale: 9144 / 360000,
);
const pica = NamedUnit(
  symbol: "P",
  singular: 'pica',
  plural: 'picas',
  dimensions: length,
  scale: 9144 / 2160000,
);
const point = NamedUnit(
  symbol: "p",
  singular: 'point',
  plural: 'points',
  dimensions: length,
  scale: 9144 / 25920000,
);
const mil = NamedUnit(
  symbol: "mil",
  singular: 'mil',
  plural: 'mils',
  dimensions: length,
  scale: 9144 / 36000000000,
);
const twip = NamedUnit(
  symbol: "twip",
  singular: 'twip',
  plural: 'twips',
  dimensions: length,
  scale: 9144 / 518400000,
);
const mile = NamedUnit(
  symbol: "mi",
  singular: 'mile',
  plural: 'miles',
  dimensions: length,
  scale: 16093440 / 10000,
);
const league = NamedUnit(
  symbol: "le",
  singular: 'league',
  plural: 'leagues',
  dimensions: length,
  scale: 48280320 / 10000,
);

const nauticalMile = NamedUnit(
  symbol: "nmi",
  singular: 'nautical mile',
  plural: 'nautical miles',
  dimensions: length,
  scale: 1852,
);

// Speed
const knot = NamedUnit(
  symbol: "kn",
  singular: 'knot',
  plural: 'knots',
  dimensions: speed,
  scale: 1852 / 3600,
);

// force
// https://en.wikipedia.org/wiki/Poundal
// TODO const poundal = NamedUnit(symbol: "pdl", dimensions: force, scale: 45359237 / 100000000 * 9144 / 3600 / 3600);
// TODO inline constexpr struct poundal final : named_unit<"pdl", pound * foot / square(si::second)> {} poundal;

// https://en.wikipedia.org/wiki/Pound_(force)
// TODO inline constexpr struct pound_force final : named_unit<"lbf", pound * si::standard_gravity> {} pound_force;

// https://en.wikipedia.org/wiki/Kip_(unit),
// TODO inline constexpr auto kip = si::kilo<pound_force>;

// pressure
// TODO inline constexpr struct psi final : named_unit<"psi", pound_force / square(inch)> {} psi;

// power
// https://en.wikipedia.org/wiki/Horsepower#Definitions
// TODO inline constexpr struct mechanical_horsepower final : named_unit<"hp(I)", mag<33'000> * foot * pound_force / si::minute> {} mechanical_horsepower;
// clang-format on

// Derived units
const milePerHour = NamedUnit(
  symbol: "mph",
  singular: 'mile per hour',
  plural: 'miles per hour',
  dimensions: speed,
  scale: 16093440 / 36000000,
);
