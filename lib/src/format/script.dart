/// Maps a digit, decimal point or minus sign string to a unicode exponent character.
const Map<int, int> superscriptRuneMap = {
  0x30: 0x2070, // '0' → '⁰'
  0x31: 0x00B9, // '1' → '¹'
  0x32: 0x00B2, // '2' → '²'
  0x33: 0x00B3, // '3' → '³'
  0x34: 0x2074, // '4' → '⁴'
  0x35: 0x2075, // '5' → '⁵'
  0x36: 0x2076, // '6' → '⁶'
  0x37: 0x2077, // '7' → '⁷'
  0x38: 0x2078, // '8' → '⁸'
  0x39: 0x2079, // '9' → '⁹'
  0x2E: 0x02D9, // '.' → '˙'
  0x2D: 0x207B, // '-' → '⁻'
};

const Map<int, int> subscriptRuneMap = {
  0x30: 0x2080, // '0' → '₀'
  0x31: 0x2081, // '1' → '₁'
  0x32: 0x2082, // '2' → '₂'
  0x33: 0x2083, // '3' → '₃'
  0x34: 0x2084, // '4' → '₄'
  0x35: 0x2085, // '5' → '₅'
  0x36: 0x2086, // '6' → '₆'
  0x37: 0x2087, // '7' → '₇'
  0x38: 0x2088, // '8' → '₈'
  0x39: 0x2089, // '9' → '₉'
  0x2E: 0x002E, // '.' → '.'
  0x2D: 0x208B, // '-' → '₋'
};

/// Maps a number string to its superscript representation.
String numToSuperscript(String num) => String.fromCharCodes(num.runes.map(
      (rune) => superscriptRuneMap[rune] ?? rune,
    ));

String numToSubscript(String num) => String.fromCharCodes(num.runes.map(
      (rune) => subscriptRuneMap[rune] ?? rune,
    ));

String ratioToScript(String numerator, String denominator) {
  final numeratorSuperscript = numToSuperscript(numerator);
  final denominatorSubscript = numToSubscript(denominator);
  return '$numeratorSuperscript\u2044$denominatorSubscript'; // Fraction slash (⁄)
}
