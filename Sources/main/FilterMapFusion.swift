public let filterMapFusionHotObservableBenchmarks = BenchmarkSuite(
  name: "FilterMapFusion"
) { suite in
  let count = samples
  let range = (1...(iterations + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    let source: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()

    _ = pipe(
      from(source),
      map { $0 + 1 },
      filter({ $0 % 2 == 1 }),
      map { $0 + 1 },
      map { $0 + 1 },
      filter({ $0 % 2 == 0 }),
      scan(0, +),
      observe({ _ in })
    )

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source(.next(i))
    }

    source(.completed(.finished))
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    let (subscriber, publisher) = ReactiveSwift.Signal<Int, Error>.pipe()

    subscriber
      .map { $0 + 1 }
      .filter({ $0 % 2 == 1 })
      .map { $0 + 1 }
      .map { $0 + 1 }
      .filter({ $0 % 2 == 0 })
      .scan(0, +)
      .observe { _ in }

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      publisher.send(value: i)
    }

    publisher.sendCompleted()
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let source = RxSwift.PublishSubject<Int>()

    source
      .map { $0 + 1 }
      .filter({ $0 % 2 == 1 })
      .map { $0 + 1 }
      .map { $0 + 1 }
      .filter({ $0 % 2 == 0 })
      .scan(0, accumulator: +)
      .subscribe()
      .disposed(by: disposeBag)

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source.onNext(i)
    }

    source.onCompleted()
  }
}

public let filterMapFusionColdObservableBenchmarks = BenchmarkSuite(
  name: "FilterMapFusion"
) { suite in
  let count = samples
  let range = (1...(iterations + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    _ = pipe(
      fromArray(range),
      map { $0 + 1 },
      filter({ $0 % 2 == 1 }),
      map { $0 + 1 },
      map { $0 + 1 },
      filter({ $0 % 2 == 0 }),
      scan(0, +),
      observe({ _ in })
    )
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    ReactiveSwift.SignalProducer<Int, Error>(range)
      .producer
      .map { $0 + 1 }
      .filter({ $0 % 2 == 1 })
      .map { $0 + 1 }
      .map { $0 + 1 }
      .filter({ $0 % 2 == 0 })
      .scan(0, +)
      .start { _ in }
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let sourceObservableA = RxSwift.Observable<Int>.from(range)

    sourceObservableA
      .map { $0 + 1 }
      .filter({ $0 % 2 == 1 })
      .map { $0 + 1 }
      .map { $0 + 1 }
      .filter({ $0 % 2 == 0 })
      .scan(0, accumulator: +)
      .subscribe()
      .disposed(by: disposeBag)
  }
}