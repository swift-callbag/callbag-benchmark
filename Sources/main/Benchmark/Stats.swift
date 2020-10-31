extension Array where Element == Double {

  var sum: Element {
    return reduce(0, +)
  }

  var average: Element {
    return sum / Element(count)
  }

  var sumSquared: Element {
    return reduce(0, { $0 + ($1 * $1)})
  }

  var mean: Element {
    if count == 0 {
      return 0
    } else {
      let invCount: Element = 1.0 / Element(count)
      return sum * invCount
    }
  }

  var median: Element {
    guard count >= 2 else { return mean }

    // If we have odd number of elements, then
    // center element is the median.
    let s = self.sorted()
    let center = count / 2
    if count % 2 == 1 {
      return s[center]
    }

    // If have even number of elements we need
    // to return an average between two middle elements.
    let center2 = count / 2 - 1
    return (s[center] + s[center2]) / 2
  }

  var std: Element {
    let c = Element(count)
    // Standard deviation is undefined for n = 0 or 1.
    guard c > 0 else { return 0 }
    guard c > 1 else { return 0 }

    let meanValue = mean
    let avgSquares = sumSquared * (1.0 / c)
    return (c / (c - 1) * (avgSquares - meanValue * meanValue)).squareRoot()
  }

  func percentile(_ v: Element) -> Element {
    if v < 0 {
      fatalError("Percentile can not be negative.")
    }
    if v > 100 {
      fatalError("Percentile can not be more than 100.")
    }
    if count == 0 {
      return 0
    }
    let sorted = self.sorted()
    let p = v / 100.0
    let index = (Element(count) - 1) * p
    var low = index
    low.round(.down)
    var high = index
    high.round(.up)
    if low == high {
      return sorted[Int(low)]
    } else {
      let lowValue = sorted[Int(low)] * (high - index)
      let highValue = sorted[Int(high)] * (index - low)
      return lowValue + highValue
    }
  }
}
