import '../common/dimensions.dart';
import '../core/unit.dart';

// const hand = RealUnit(symbol: "hh", dimensions: length, scale: );
// const barleycorn = RealUnit(symbol: "Bc", dimensions: length);
//
// // clang-format off
// // https://en.wikipedia.org/wiki/Imperial_units#Length
// inline constexpr struct hand final : named_unit<"hh", mag_ratio<1, 3> * foot> {} hand;
// inline constexpr struct barleycorn final : named_unit<"Bc", mag_ratio<1, 3> * inch> {} barleycorn;
// inline constexpr struct thou final : named_unit<"th", mag_ratio<1, 12'000> * foot> {} thou;
// inline constexpr struct chain final : named_unit<"ch", mag<22> * yard> {} chain;
// inline constexpr struct furlong final : named_unit<"fur", mag<10> * chain> {} furlong;
//
// // maritime units
// inline constexpr struct cable final : named_unit<"cb", mag_ratio<1, 10> * nautical_mile> {} cable;
// inline constexpr struct fathom final : named_unit<"ftm", mag_ratio<1, 1000> * nautical_mile> {} fathom;
//
// // survey
// inline constexpr struct link final : named_unit<"li", mag_ratio<1, 100> * chain> {} link;
// inline constexpr struct rod final : named_unit<"rd", mag<25> * link> {} rod;
//
// // https://en.wikipedia.org/wiki/Imperial_units#Area

const acre = NamedUnit(
  symbol: "ac",
  singular: 'acre',
  plural: 'acres',
  dimensions: area,
  scale: 4046.8564224,
);
// inline constexpr struct perch final : named_unit<"perch", square(rod)> {} perch;
// inline constexpr struct rood final : named_unit<"rood", mag<40> * perch> {} rood;
// inline constexpr struct acre final : named_unit<"acre", mag<4> * rood> {} acre;
//
// // https://en.wikipedia.org/wiki/Imperial_units#Volume
// inline constexpr struct gallon final : named_unit<"gal", mag_ratio<454'609, 100'000> * si::litre> {} gallon;
// inline constexpr struct quart final : named_unit<"qt", mag_ratio<1, 4> * gallon> {} quart;
// inline constexpr struct pint final : named_unit<"pt", mag_ratio<1, 2> * quart> {} pint;
// inline constexpr struct gill final : named_unit<"gi", mag_ratio<1, 4> * pint> {} gill;
// inline constexpr struct fluid_ounce final : named_unit<"fl oz", mag_ratio<1, 5> * gill> {} fluid_ounce;
//
// // https://en.wikipedia.org/wiki/Avoirdupois_system#Post-Elizabethan_units
// inline constexpr auto drachm = dram;
// inline constexpr struct stone final : named_unit<"st", mag<14> * pound> {} stone;
// inline constexpr struct quarter final : named_unit<"qr", mag<2> * stone> {} quarter;
// inline constexpr struct long_hundredweight final : named_unit<"cwt", mag<8> * stone> {} long_hundredweight;
// inline constexpr struct ton final : named_unit<"t", mag<2'240> * pound> {} ton;
// inline constexpr auto long_ton = ton;

const bushel = NamedUnit(
  symbol: 'bu',
  singular: 'bushel (imp)',
  plural: 'bushels (imp)',
  dimensions: volume,
  scale: 0.03636872,
);
