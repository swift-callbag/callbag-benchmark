public let combineHotObservableBenchmarks = BenchmarkSuite(
  name: "Combine"
) { suite in
  let count = samples
  let range = (1...((iterations / 2) + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    let source1: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()
    let source2: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()
    let source3: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()
    let source4: CallbagKit.Subject<Int> = CallbagKit.makePublishSubject()

    _ = pipe(
      combine(
        from(source1),
        from(source2),
        from(source3),
        from(source4)
      ),
      map { $0 + $1 + $2 + $3 },
      filter { $0 % 2 == 0 },
      observe({ _ in })
    )

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source1(.next(i))
      source2(.next(i))
      source3(.next(i))
      source4(.next(i))
    }

    source1(.completed(.finished))
    source2(.completed(.finished))
    source3(.completed(.finished))
    source4(.completed(.finished))
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    let (subscriber1, publisher1) = ReactiveSwift.Signal<Int, Error>.pipe()
    let (subscriber2, publisher2) = ReactiveSwift.Signal<Int, Error>.pipe()
    let (subscriber3, publisher3) = ReactiveSwift.Signal<Int, Error>.pipe()
    let (subscriber4, publisher4) = ReactiveSwift.Signal<Int, Error>.pipe()

    ReactiveSwift.Signal
      .combineLatest(subscriber1, subscriber2, subscriber3, subscriber4)
      .map { $0 + $1 + $2 + $3 }
      .filter { $0 % 2 == 0 }
      .observe { _ in }

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      publisher1.send(value: i)
      publisher2.send(value: i)
      publisher3.send(value: i)
      publisher4.send(value: i)
    }

    publisher1.sendCompleted()
    publisher2.sendCompleted()
    publisher3.sendCompleted()
    publisher4.sendCompleted()
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let source1 = RxSwift.PublishSubject<Int>()
    let source2 = RxSwift.PublishSubject<Int>()
    let source3 = RxSwift.PublishSubject<Int>()
    let source4 = RxSwift.PublishSubject<Int>()

    RxSwift.Observable
      .combineLatest(source1, source2, source3, source4)
      .map { $0 + $1 + $2 + $3 }
      .filter { $0 % 2 == 0 }
      .subscribe()
      .disposed(by: disposeBag)

    var iterator = range.makeIterator()
    while let i = iterator.next() {
      source1.onNext(i)
      source2.onNext(i)
      source3.onNext(i)
      source4.onNext(i)
    }

    source1.onCompleted()
    source2.onCompleted()
    source3.onCompleted()
    source4.onCompleted()
  }
}

public let combineColdObservableBenchmarks = BenchmarkSuite(
  name: "Combine"
) { suite in
  let count = samples
  let range = (1...((iterations / 2) + 1))

  suite.benchmark("CallbagKit", settings: Iterations(count)) {
    let source1 = fromArray(range)
    let source2 = fromArray(range)
    let source3 = fromArray(range)
    let source4 = fromArray(range)

    _ = pipe(
      combine(
        source1,
        source2,
        source3,
        source4
      ),
      map { $0 + $1 + $2 + $3 },
      filter { $0 % 2 == 0 },
      observe({ _ in })
    )
  }
  
  suite.benchmark("ReactiveSwift", settings: Iterations(count)) {
    let source1 = ReactiveSwift.SignalProducer<Int, Error>(range)
    let source2 = ReactiveSwift.SignalProducer<Int, Error>(range)
    let source3 = ReactiveSwift.SignalProducer<Int, Error>(range)
    let source4 = ReactiveSwift.SignalProducer<Int, Error>(range)

    ReactiveSwift.SignalProducer
      .combineLatest(source1, source2, source3, source4)
      .map { $0 + $1 + $2 + $3 }
      .filter { $0 % 2 == 0 }
      .producer
      .start { _ in }
  }

  suite.benchmark("RxSwift", settings: Iterations(count)) {
    let disposeBag = RxSwift.DisposeBag()
    let source1 = RxSwift.Observable<Int>.from(range)
    let source2 = RxSwift.Observable<Int>.from(range)
    let source3 = RxSwift.Observable<Int>.from(range)
    let source4 = RxSwift.Observable<Int>.from(range)

    RxSwift.Observable
      .combineLatest(source1, source2, source3, source4)
      .map { $0 + $1 + $2 + $3 }
      .filter { $0 % 2 == 0 }
      .subscribe()
      .disposed(by: disposeBag)
  }
}