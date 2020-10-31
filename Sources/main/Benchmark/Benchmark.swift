public struct Benchmark {
  public static func main(
    _ suites: Array<BenchmarkSuite>
  ) {
    var iterator = suites.makeIterator()
    while let suite = iterator.next() {
      var iterator = suite.microBenchmarks.makeIterator()

      var rows: Array<Array<String>> = .init()


      rows.append(
        [
          "library",
          "time",
          "std"//,
          // "iterations",
          // "median",
          // "min",
          // "max",
          // "total",
          // "avg",
          // "std_abs"
        ]
      )

      while let microBenchmark = iterator.next() {
        print("running \(suite.name) - \(microBenchmark.0)...")
        let measurements = benchmark(iterations: microBenchmark.1.iterations, execute: microBenchmark.2)
        print("done! (\(time(measurements.average)) secs)")

        rows.append(
          [
            microBenchmark.0,
            time(measurements.average),
            stdPercentage(measurements.std / measurements.average * 100)//,
            // (measurements.count).description,
            // time(measurements.median),
            // time(measurements.min() ?? 0),
            // time(measurements.max() ?? 0),
            // (measurements.sum).description,
            // (measurements.average).description,
            // std(measurements.std)
          ]
        )
      }

      print(suite.name)
      print(table: rows)
    }
  }

  public static func markdown(
    _ suitesA: Array<BenchmarkSuite>,
    _ suitesB: Array<BenchmarkSuite>
  ) {
    var iterator = zip(suitesA, suitesB).makeIterator()
    while let suite = iterator.next() {
      var iterator = zip(suite.0.microBenchmarks, suite.1.microBenchmarks).makeIterator()

      var rows: Array<Array<String>> = .init()

      rows.append(
        [
          "library",
          "time",
          "std"//,
          // "iterations",
          // "median",
          // "min",
          // "max",
          // "total",
          // "avg",
          // "std_abs"
        ]
      )

      while let microBenchmark = iterator.next() {
        let measurementsA = benchmark(iterations: microBenchmark.0.1.iterations, execute: microBenchmark.0.2)
        let measurementsB = benchmark(iterations: microBenchmark.1.1.iterations, execute: microBenchmark.1.2)

        rows.append(
          [
            microBenchmark.0.0,

            time(measurementsA.average),
            stdPercentage(measurementsA.std / measurementsA.average * 100),
            // (measurementsA.count).description,
            // time(measurementsA.median),
            // time(measurementsA.min() ?? 0),
            // time(measurementsA.max() ?? 0),
            // (measurementsA.sum).description,
            // (measurementsA.average).description,
            // std(measurementsA.std),

            time(measurementsB.average),
            stdPercentage(measurementsB.std / measurementsB.average * 100)//,
            // (measurementsB.count).description,
            // time(measurementsB.median),
            // time(measurementsB.min() ?? 0),
            // time(measurementsB.max() ?? 0),
            // (measurementsB.sum).description,
            // (measurementsB.average).description,
            // std(measurementsB.std)
          ]
        )
      }

      var output = String()
      var rowsIterator = rows.makeIterator()
      output.append("<table>\n")
      output.append("\t<thead>\n")
      output.append("\t\t<tr>\n")
      output.append("\t\t\t<td style=\"text-align: center\" colspan=\"\(rows.last!.count)\"><a href=\"./Sources/main/\(suite.0.name).swift\">\(suite.0.name)</a></td>\n") // colspan==5
      output.append("\t\t</tr>\n")

      var headers = rowsIterator.next()!.makeIterator()
      output.append("\t\t<tr>\n")
      if let library = headers.next() {
        output.append("\t\t\t<td rowspan=\"2\"><strong>\(library)</strong></td>\n")
        output.append("\t\t\t<td style=\"text-align: center\" colspan=\"\(rows.first!.count-1)\"><strong>Cold - Observable</strong></td>\n") // colspan==2
        output.append("\t\t\t<td style=\"text-align: center\" colspan=\"\(rows.first!.count-1)\"><strong>Hot - Observable</strong></td>\n") // colspan==2
      }
      output.append("\t\t</tr>\n")
      output.append("\t\t<tr>\n")
      var attr = String()
      while let header = headers.next() {
        attr.append("\t\t\t<td><strong>\(header)</strong></td>\n")
      }
      output.append(attr) /// suiteA
      output.append(attr) /// suiteB
      output.append("\t\t</tr>\n")
      output.append("\t</thead>\n")


      output.append("\t<tbody>\n")
      while var cells = rowsIterator.next()?.makeIterator() {
        output.append("\t\t<tr>\n")
        if let library = cells.next() {
          switch library {
          case "CallbagKit":
            output.append("\t\t\t<td><b>Callbag</b>Kit</td>\n")
          case "ReactiveSwift":
            output.append("\t\t\t<td><b>Reactive</b>Swift</td>\n")
          case "RxSwift":
            output.append("\t\t\t<td><b>Rx</b>Swift</td>\n")
          default:
            output.append("\t\t\t<td>\(library)</td>\n")
          }
        }
        while let cell = cells.next() {
          if cell.count-4 > 0, cell.dropFirst(cell.count-4) == "secs" {
            output.append("\t\t\t<td style=\"text-align: right\">\(cell)</td>\n")
          } else {
            output.append("\t\t\t<td>\(cell)</td>\n")
          }
        }
        output.append("\t\t</tr>\n")
      }
      output.append("\t</tbody>\n")
      output.append("</table>\n")
      output.append("<br>\n")
      
      print(
        output.replacingOccurrences(of: "\t", with: "  ")
      )
    }
  }
}

private typealias MicroBenchmark = (String, BenchmarkSettings, () -> Void)

public struct BenchmarkSuite {
  public let name: String
  fileprivate var microBenchmarks: Array<MicroBenchmark>

  public init(
    name: String,
    _ suites: (inout BenchmarkSuite) -> Void
  ) {
    self.name = name
    self.microBenchmarks = .init()
    suites(&self)
  }

  public mutating func benchmark(
    _ subtitle: String,
    settings: BenchmarkSettings,
    _ benchmarkClosure: @escaping () -> Void
  ) {
    self.microBenchmarks.append(
      (subtitle, settings, benchmarkClosure)
    )
  }
}

public protocol BenchmarkSettings {
  var iterations: Int { get }
}

public struct Iterations: BenchmarkSettings {
  public let iterations: Int

  public init(
    _ iterations: Int
  ) {
    self.iterations = iterations
  }
}