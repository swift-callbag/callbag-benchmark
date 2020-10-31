@_exported import CallbagKit
@_exported import ReactiveSwift
@_exported import RxSwift

@_exported import Foundation
@_exported import Dispatch

// listenable from
func fromArray<S: Sequence>(
  _ sequence: S
) -> Producer<S.Element> {
  return { sink in
    var iterator = sequence.makeIterator()
    sink(.start({ _ in }))
    while let element = iterator.next() {
      sink(.next(element))
    }
    sink(.completed(.finished))
  }
}

let samples = 10
let iterations = 1000000

let coldObservablesBenchmarkSuite: Array<BenchmarkSuite> = Array(arrayLiteral:
  dataFlowColdObservableBenchmarks,
  foldColdObservableBenchmarks,
  filterMapReduceColdObservableBenchmarks,
  filterMapFusionColdObservableBenchmarks,
  combineColdObservableBenchmarks,
  zipColdObservableBenchmarks,
  mergeColdObservableBenchmarks
)

let hotObservablesBenchmarkSuite: Array<BenchmarkSuite> = Array(arrayLiteral:
  dataFlowHotObservableBenchmarks,
  foldHotObservableBenchmarks,
  filterMapReduceHotObservableBenchmarks,
  filterMapFusionHotObservableBenchmarks,
  combineHotObservableBenchmarks,
  zipHotObservableBenchmarks,
  mergeHotObservableBenchmarks
)

print("Cold - Observable")
Benchmark.main(coldObservablesBenchmarkSuite)
print("Hot - Observable")
Benchmark.main(hotObservablesBenchmarkSuite)