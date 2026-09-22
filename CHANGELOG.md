### 0.7.0
  * **Breaking**: `Quantity` and `Unit` hash codes are now consistent with equality, as required by
    `Object.hashCode`. Equal quantities expressed in different units (`1 m` and `1000 mm`) previously
    hashed differently, so a `Set` or `Map` kept both
  * **Breaking**: `Quantity` comparison is now performed in SI base units rather than by converting one
    operand to the units of the other, which previously made equality asymmetric for ~7% of unit conversions
  * **Breaking**: `Quantity.operator ==` now returns `false` for mismatched dimensions rather than
    throwing, as `List.contains` and other collection operations rely on it. `compareTo` and the
    ordering operators still throw
  * **Breaking**: a scalar `Quantity` is no longer equal to the `num` it represents. `num` could not
    return the same in reverse, and the comparison was reported as `unrelated_type_equality_checks`
    at every call site. `Scalar`'s ordering operators still accept a `num`
  * **Breaking**: `QuantityPoint` hash codes now follow its existing equality, which compares the
    distance from absolute zero regardless of units and origin
  * Added `QuantityPoint` string functions, showing the origin where the unit does not imply it
  * Added `OffsetUnit`, a unit measured from a `Unit.implicitOrigin`; `degreeCelsius` and `degreeFahrenheit` are now offset units
  * Added `QuantityOrigin` equality, `isZero` and `toString`
  * Fixed the names of `degreeCelsius`, which had none, and the plural of `kelvin`

### 0.6.2
  * Added `AreaPerTime` and `AnglePerTime` quantities

### 0.6.1
  * Add fixed precision functions Quantity.toPrecision and Quantity.toFixedAsStringNoTrailing

### 0.6.0
  * Renamed `systems` to `units`
  * Moved scalar units to `units/scalar.dart`
  * Quantity.scaled() now accepts a `num` as well as a `Quantity`

### 0.5.1
  * Fixed prefixed unit scaling [2c393b1](https://github.com/nebkat/dart-physical/commit/2c393b1a9836ca5ea5aae435c866167feceda6b4)
  * Reorganized examples

### 0.5.0
  * Various improvements.
