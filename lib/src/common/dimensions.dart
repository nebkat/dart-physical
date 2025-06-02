import '../core/dimensions.dart';

const dimensionless = Dimensions.empty();
const length = Dimensions.constant({Dimension.length: 1});
const mass = Dimensions.constant({Dimension.mass: 1});
const time = Dimensions.constant({Dimension.time: 1});
const temperature = Dimensions.constant({Dimension.temperature: 1});
const electricCurrent = Dimensions.constant({Dimension.electricCurrent: 1});
const luminousIntensity = Dimensions.constant({Dimension.luminousIntensity: 1});
const amountOfSubstance = Dimensions.constant({Dimension.amountOfSubstance: 1});
const angle = Dimensions.constant({Dimension.angle: 1});
const solidAngle = Dimensions.constant({Dimension.solidAngle: 1});

const area = Dimensions.constant({Dimension.length: 2});
const volume = Dimensions.constant({Dimension.length: 3});
const speed = Dimensions.constant({Dimension.length: 1, Dimension.time: -1});

const massPerVolume = Dimensions.constant({Dimension.mass: 1, Dimension.length: -3});
const massPerTime = Dimensions.constant({Dimension.mass: 1, Dimension.time: -1});
const massPerArea = Dimensions.constant({Dimension.mass: 1, Dimension.length: -2});

const volumePerMass = Dimensions.constant({Dimension.length: 3, Dimension.mass: -1});
const volumePerTime = Dimensions.constant({Dimension.length: 3, Dimension.time: -1});
const volumePerArea = Dimensions.constant({Dimension.length: 1});

const frequency = Dimensions.constant({Dimension.time: -1});
const force = Dimensions.constant({Dimension.mass: 1, Dimension.length: 1, Dimension.time: -2});
const pressure = Dimensions.constant({Dimension.mass: 1, Dimension.length: -1, Dimension.time: -2});
const energy = Dimensions.constant({Dimension.mass: 1, Dimension.length: 2, Dimension.time: -2});
const power = Dimensions.constant({Dimension.mass: 1, Dimension.length: 2, Dimension.time: -3});
const voltage = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.length: 2,
  Dimension.time: -3,
  Dimension.electricCurrent: -1,
});
const electricCharge = Dimensions.constant({Dimension.electricCurrent: 1, Dimension.time: 1});
const electricPotential = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.length: 2,
  Dimension.time: -3,
  Dimension.electricCurrent: -1,
});
const capacitance = Dimensions.constant({
  Dimension.mass: -1,
  Dimension.length: -2,
  Dimension.time: 4,
  Dimension.electricCurrent: 2,
});
const resistance = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.length: 2,
  Dimension.time: -3,
  Dimension.electricCurrent: -2,
});
const conductance = Dimensions.constant({
  Dimension.mass: -1,
  Dimension.length: -2,
  Dimension.time: 3,
  Dimension.electricCurrent: 2,
});
const inductance = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.length: 2,
  Dimension.time: -2,
  Dimension.electricCurrent: -2,
});
const magneticFlux = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.length: 2,
  Dimension.time: -2,
  Dimension.electricCurrent: -1,
});
const magneticFluxDensity = Dimensions.constant({
  Dimension.mass: 1,
  Dimension.time: -2,
  Dimension.electricCurrent: -1,
});

const luminousFlux = Dimensions.constant({Dimension.luminousIntensity: 1, Dimension.solidAngle: 1});
const illuminance = Dimensions.constant({Dimension.luminousIntensity: 1, Dimension.length: -2});

// TODO Use these when more const available https://github.com/dart-lang/language/pull/4374
// final area = length ^ 2;
// final volume = length ^ 3;
// final acceleration = length / (time ^ 2);
// final speed = length / time;
//
// final massPerVolume = mass / volume;
// final massPerArea = mass / area;
// final massPerTime = mass / time;
//
// final volumePerMass = volume / mass;
// final volumePerArea = volume / area;
// final volumePerTime = volume / time;
//
// final frequency = time ^ -1;
// final force = mass * acceleration;
// final pressure = force / area;
// final energy = force * length;
// final power = energy / time;
//
// final electricCharge = electricCurrent * time;
// final voltage = energy / electricCharge;
// final capacitance = electricCharge / voltage;
// final resistance = voltage / electricCurrent;
// final conductance = electricCurrent / voltage;
// final inductance = voltage / (electricCurrent / time);
// final magneticFlux = voltage * time;
// final magneticFluxDensity = magneticFlux / area;
//
// final luminousFlux = luminousIntensity * solidAngle;
// final illuminance = luminousIntensity / area;
//
// final definitions = {
//   'area': area,
//   'volume': volume,
//   'acceleration': acceleration,
//   'speed': speed,
//   'massPerVolume': massPerVolume,
//   'massPerArea': massPerArea,
//   'massPerTime': massPerTime,
//   'volumePerMass': volumePerMass,
//   'volumePerArea': volumePerArea,
//   'volumePerTime': volumePerTime,
//   'frequency': frequency,
//   'force': force,
//   'pressure': pressure,
//   'energy': energy,
//   'power': power,
//   'electricCharge': electricCharge,
//   'voltage': voltage,
//   'capacitance': capacitance,
//   'resistance': resistance,
//   'conductance': conductance,
//   'inductance': inductance,
//   'magneticFlux': magneticFlux,
//   'magneticFluxDensity': magneticFluxDensity,
//   'luminousFlux': luminousFlux,
//   'illuminance': illuminance
// };
