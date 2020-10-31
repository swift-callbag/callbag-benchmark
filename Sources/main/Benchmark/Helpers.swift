import struct Dispatch.DispatchTime
import func Foundation.pow

@inline(__always)
var now: UInt64 {
  return DispatchTime.now().uptimeNanoseconds
}

func calculateExecutionsPerSecond(_ samples: Int, _ iterations: Int, _ seconds: Double) -> Double {
  // print(seconds)
  let totalExecutions = Double(samples) * Double(iterations)
  let executionsPerSecond = totalExecutions / (seconds)
  return executionsPerSecond
}

func rounded(_ x: Double, to decimalPlaces: Int = 2) -> Double {
  let nPlaces = Double("\(pow(10, decimalPlaces))")!
  return (x * nPlaces).rounded() / nPlaces
}

func enforceInt(_ x: Double) -> Int {
  return (x == Double.nan || x == Double.infinity) ? 0 : Int(x)
}

func lineUpDecimalPoint(_ numbers: [Double]) -> [String] {
  let length = numbers.map(enforceInt).map(String.init).map { $0.count }
  let maxSpaces = length.max()!
  return numbers.enumerated().map { String(Array(repeating: " ", count: maxSpaces - length[$0])) + "\($1)" }
}

func benchmark(
  iterations ntimes: Int = 1,
  execute: () -> Void
) -> Array<Double> {
  var times = Array<Double>()

  var iterator = (0..<ntimes).makeIterator()
  while case .some = iterator.next() {
    let start = Double(now)
    execute()
    let end = Double(now)
    times.append(end - start)
  }

  // let total = Double(times.reduce(0, +))
  // let average_secs: Double = (total / Double(ntimes))

  return times
}

let number: (Double) -> String = { (value) in
  let string = String(value)
  if string.hasSuffix(".0") {
    return String(string.dropLast(2))
  } else {
    return String(format: "%.3f", value)
  }
}

/// Show number with the corresponding time unit.
let time: (Double) -> String = { (value) in
  let num = number(value / 1_000_000_000.0)
  return "\(num) secs"
}

/// Show value as percentage.
let percentage: (Double) -> String = { (value) in
  return String(format: "%6.2f %%", value)
}

/// Show value as plus or minus standard deviation.
let std: (Double) -> String = { (value) in
  let num = number(value)
  return "± \(num)"
}

/// Show value as plus or minus standard deviation in percentage.
let stdPercentage: (Double) -> String = { (value) in
  return "± " + String(format: "%6.2f %%", value)
}
