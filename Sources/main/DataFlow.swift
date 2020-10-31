public let dataFlowHotObservableBenchmarks = BenchmarkSuite(
  name: "DataFlow"
) { suite in
  let count = samples
  let range = (1...(iterations + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    let source: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()

    let inc = pipe(
      from(source),
      filter(even),
      map { _ in 1 }
    )
    let dec = pipe(
      from(source),
      filter(odd),
      map { _ in -1 }
    )
    let count = pipe(
      merge(inc, dec),
      scan(0, +)
    )
    let label: CallbagKit.Subject<String> = CallbagKit.makePublishSubject()
    _ = pipe(
      combine(from(label), count),
      map { [$0, $1] },
      observe({ _ in })
    )

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source(.next(i))
      if i % 2 == 0 {
        label(.next("initial"))
      } else {
        label(.next("Count is "))
      }
    }

    source(.completed(.finished))
    label(.completed(.finished))
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    let (subscriber, publisher) = ReactiveSwift.Signal<Int, Error>.pipe()

    let inc = subscriber.filter(even).map { _ in 1 }
    let dec = subscriber.filter(even).map { _ in -1 }

    let count = ReactiveSwift.Signal.merge(inc, dec).scan(0, +)

    let (labelSubscriber, labelPublisher) = ReactiveSwift.Signal<String, Error>.pipe()

    ReactiveSwift.Signal
      .combineLatest(labelSubscriber, count)
      .map { [$0, $1] }
      .observe { _ in }

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      publisher.send(value: i)
      if i % 2 == 0 {
        labelPublisher.send(value: "initial")
      } else {
        labelPublisher.send(value: "Count is ")
      }
    }

    publisher.sendCompleted()
    labelPublisher.sendCompleted()
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let source = RxSwift.PublishSubject<Int>()

    let inc = source.filter(even).map { _ in 1 }
    let dec = source.filter(even).map { _ in -1 }

    let count = RxSwift.Observable.merge(inc, dec).scan(0, accumulator: +)

    let label = RxSwift.PublishSubject<String>()

    RxSwift.Observable
      .combineLatest(label, count)
      .map { [$0, $1] }
      .subscribe()
      .disposed(by: disposeBag)

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source.onNext(i)
      if i % 2 == 0 {
        label.onNext("initial")
      } else {
        label.onNext("Count is ")
      }
    }

    source.onCompleted()
    label.onCompleted()
  }
}

public let dataFlowColdObservableBenchmarks = BenchmarkSuite(
  name: "DataFlow"
) { suite in
  let count = samples
  let range = (1...(iterations + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    let source = fromArray(range)

    let inc = pipe(
      source,
      filter(even),
      map { _ in 1 }
    )
    let dec = pipe(
      source,
      filter(odd),
      map { _ in -1 }
    )
    let count = pipe(
      merge(inc, dec),
      scan(0, +)
    )
    let label = fromArray(["initial", "Count is "])
    _ = pipe(
      combine(label, count),
      map { [$0, $1] },
      observe({ _ in })
    )
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    let source = ReactiveSwift.SignalProducer<Int, Error>(range)

    let inc = source.filter(even).map { _ in 1 }
    let dec = source.filter(even).map { _ in -1 }

    let count = ReactiveSwift.SignalProducer.merge(inc, dec).scan(0, +)

    let label = ReactiveSwift.SignalProducer<String, Error>(["initial", "Count is "])

    ReactiveSwift.SignalProducer
      .combineLatest(label, count)
      .map { [$0, $1] }
      .producer
      .start { _ in }
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let source = RxSwift.Observable<Int>.from(range)

    let inc = source.filter(even).map { _ in 1 }
    let dec = source.filter(even).map { _ in -1 }

    let count = RxSwift.Observable.merge(inc, dec).scan(0, accumulator: +)

    let label = RxSwift.Observable<String>.from(["initial", "Count is "])

    RxSwift.Observable
      .combineLatest(label, count)
      .map { [$0, $1] }
      .subscribe()
      .disposed(by: disposeBag)
  }
}