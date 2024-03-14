/*
@frozen
public struct Slice<Base: Collection> {
    public var _startIndex: Base.Index
    public var _endIndex: Base.Index
    
    @usableFromInline
    internal var _base: Base

    @inlinable
    public init(base: Base, bounds: Range<Base.Index>) {
        self._base = base
        self._startIndex = bounds.lowerBound
        self._endIndex = bounds.upperBound
    }

    @inlinable
    public var base: Base {
        return _base
    }
    
    @_alwaysEmitIntoClient
    @inline(__always)
    internal var _bounds: Range<Base.Index> {
        Range(_uncheckedBounds: (_startIndex, _endIndex))
    }
}

extension Slice: Collection {
  public typealias Index = Base.Index
  public typealias Indices = Base.Indices
  public typealias Element = Base.Element
  public typealias SubSequence = Slice<Base>
  public typealias Iterator = IndexingIterator<Slice<Base>>

  @inlinable
  public var startIndex: Index {
    return _startIndex
  }

  @inlinable
  public var endIndex: Index {
    return _endIndex
  }

  @inlinable
  public subscript(index: Index) -> Base.Element {
    get {
      _failEarlyRangeCheck(index, bounds: _bounds)
      return _base[index]
    }
  }

  @inlinable
  public subscript(bounds: Range<Index>) -> Slice<Base> {
    get {
      _failEarlyRangeCheck(bounds, bounds: _bounds)
      return Slice(base: _base, bounds: bounds)
    }
  }

  public var indices: Indices {
    return _base.indices[_bounds]
  }

  @inlinable
  public func index(after i: Index) -> Index {
    // FIXME: swift-3-indexing-model: range check.
    return _base.index(after: i)
  }

  @inlinable
  public func formIndex(after i: inout Index) {
    // FIXME: swift-3-indexing-model: range check.
    _base.formIndex(after: &i)
  }

  @inlinable
  public func index(_ i: Index, offsetBy n: Int) -> Index {
    // FIXME: swift-3-indexing-model: range check.
    return _base.index(i, offsetBy: n)
  }

  @inlinable
  public func index(
    _ i: Index, offsetBy n: Int, limitedBy limit: Index
  ) -> Index? {
    // FIXME: swift-3-indexing-model: range check.
    return _base.index(i, offsetBy: n, limitedBy: limit)
  }

  @inlinable
  public func distance(from start: Index, to end: Index) -> Int {
    // FIXME: swift-3-indexing-model: range check.
    return _base.distance(from: start, to: end)
  }

  @inlinable
  public func _failEarlyRangeCheck(_ index: Index, bounds: Range<Index>) {
    _base._failEarlyRangeCheck(index, bounds: bounds)
  }

  @inlinable
  public func _failEarlyRangeCheck(_ range: Range<Index>, bounds: Range<Index>) {
    _base._failEarlyRangeCheck(range, bounds: bounds)
  }

  @_alwaysEmitIntoClient @inlinable
  public func withContiguousStorageIfAvailable<R>(
    _ body: (UnsafeBufferPointer<Element>) throws -> R
  ) rethrows -> R? {
    try _base.withContiguousStorageIfAvailable { buffer in
      let start = _base.distance(from: _base.startIndex, to: _startIndex)
      let count = _base.distance(from: _startIndex, to: _endIndex)
      let slice = UnsafeBufferPointer(rebasing: buffer[start ..< start + count])
      return try body(slice)
    }
  }
}

extension Slice {
  @_alwaysEmitIntoClient
  public __consuming func _copyContents(
      initializing buffer: UnsafeMutableBufferPointer<Element>
  ) -> (Iterator, UnsafeMutableBufferPointer<Element>.Index) {
    if let (_, copied) = self.withContiguousStorageIfAvailable({
      $0._copyContents(initializing: buffer)
    }) {
      let position = index(startIndex, offsetBy: copied)
      return (Iterator(_elements: self, _position: position), copied)
    }

    return _copySequenceContents(initializing: buffer)
  }
}

extension Slice: BidirectionalCollection where Base: BidirectionalCollection {
  @inlinable
  public func index(before i: Index) -> Index {
    // FIXME: swift-3-indexing-model: range check.
    return _base.index(before: i)
  }

  @inlinable
  public func formIndex(before i: inout Index) {
    // FIXME: swift-3-indexing-model: range check.
    _base.formIndex(before: &i)
  }
}


extension Slice: MutableCollection where Base: MutableCollection {
  @inlinable
  public subscript(index: Index) -> Base.Element {
    get {
      _failEarlyRangeCheck(index, bounds: _bounds)
      return _base[index]
    }
    set {
      _failEarlyRangeCheck(index, bounds: _bounds)
      _base[index] = newValue
      // MutableSlice requires that the underlying collection's subscript
      // setter does not invalidate indices, so our `startIndex` and `endIndex`
      // continue to be valid.
    }
  }

  @inlinable
  public subscript(bounds: Range<Index>) -> Slice<Base> {
    get {
      _failEarlyRangeCheck(bounds, bounds: _bounds)
      return Slice(base: _base, bounds: bounds)
    }
    set {
      _writeBackMutableSlice(&self, bounds: bounds, slice: newValue)
    }
  }

  @_alwaysEmitIntoClient @inlinable
  public mutating func withContiguousMutableStorageIfAvailable<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R? {
    // We're calling `withContiguousMutableStorageIfAvailable` twice here so
    // that we don't calculate index distances unless we know we'll use them.
    // The expectation here is that the base collection will make itself
    // contiguous on the first try and the second call will be relatively cheap.
    guard _base.withContiguousMutableStorageIfAvailable({ _ in }) != nil
    else {
      return nil
    }
    let start = _base.distance(from: _base.startIndex, to: _startIndex)
    let count = _base.distance(from: _startIndex, to: _endIndex)
    return try _base.withContiguousMutableStorageIfAvailable { buffer in
      var slice = UnsafeMutableBufferPointer(
        rebasing: buffer[start ..< start + count])
      let copy = slice
      defer {
        _precondition(
          slice.baseAddress == copy.baseAddress &&
          slice.count == copy.count,
          "Slice.withContiguousMutableStorageIfAvailable: replacing the buffer is not allowed")
      }
      return try body(&slice)
    }
  }
}


extension Slice: RandomAccessCollection where Base: RandomAccessCollection { }

extension Slice: RangeReplaceableCollection
  where Base: RangeReplaceableCollection {
  @inlinable
  public init() {
    self._base = Base()
    self._startIndex = _base.startIndex
    self._endIndex = _base.endIndex
  }

  @inlinable
  public init(repeating repeatedValue: Base.Element, count: Int) {
    self._base = Base(repeating: repeatedValue, count: count)
    self._startIndex = _base.startIndex
    self._endIndex = _base.endIndex
  }

  @inlinable
  public init<S>(_ elements: S) where S: Sequence, S.Element == Base.Element {
    self._base = Base(elements)
    self._startIndex = _base.startIndex
    self._endIndex = _base.endIndex
  }

  @inlinable
  public mutating func replaceSubrange<C>(
    _ subRange: Range<Index>, with newElements: C
  ) where C: Collection, C.Element == Base.Element {

    // FIXME: swift-3-indexing-model: range check.
    let sliceOffset =
      _base.distance(from: _base.startIndex, to: _startIndex)
    let newSliceCount =
      _base.distance(from: _startIndex, to: subRange.lowerBound)
      + _base.distance(from: subRange.upperBound, to: _endIndex)
      + newElements.count
    _base.replaceSubrange(subRange, with: newElements)
    _startIndex = _base.index(_base.startIndex, offsetBy: sliceOffset)
    _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
  }

  @inlinable
  public mutating func insert(_ newElement: Base.Element, at i: Index) {
    // FIXME: swift-3-indexing-model: range check.
    let sliceOffset = _base.distance(from: _base.startIndex, to: _startIndex)
    let newSliceCount = count + 1
    _base.insert(newElement, at: i)
    _startIndex = _base.index(_base.startIndex, offsetBy: sliceOffset)
    _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
  }

  @inlinable
  public mutating func insert<S>(contentsOf newElements: S, at i: Index)
  where S: Collection, S.Element == Base.Element {

    // FIXME: swift-3-indexing-model: range check.
    let sliceOffset = _base.distance(from: _base.startIndex, to: _startIndex)
    let newSliceCount = count + newElements.count
    _base.insert(contentsOf: newElements, at: i)
    _startIndex = _base.index(_base.startIndex, offsetBy: sliceOffset)
    _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
  }

  @inlinable
  public mutating func remove(at i: Index) -> Base.Element {
    // FIXME: swift-3-indexing-model: range check.
    let sliceOffset = _base.distance(from: _base.startIndex, to: _startIndex)
    let newSliceCount = count - 1
    let result = _base.remove(at: i)
    _startIndex = _base.index(_base.startIndex, offsetBy: sliceOffset)
    _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
    return result
  }

  @inlinable
  public mutating func removeSubrange(_ bounds: Range<Index>) {
    // FIXME: swift-3-indexing-model: range check.
    let sliceOffset = _base.distance(from: _base.startIndex, to: _startIndex)
    let newSliceCount =
      count - distance(from: bounds.lowerBound, to: bounds.upperBound)
    _base.removeSubrange(bounds)
    _startIndex = _base.index(_base.startIndex, offsetBy: sliceOffset)
    _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
  }
}

extension Slice
  where Base: RangeReplaceableCollection, Base: BidirectionalCollection {
  
  @inlinable
  public mutating func replaceSubrange<C>(
    _ subRange: Range<Index>, with newElements: C
  ) where C: Collection, C.Element == Base.Element {
    // FIXME: swift-3-indexing-model: range check.
    if subRange.lowerBound == _base.startIndex {
      let newSliceCount =
        _base.distance(from: _startIndex, to: subRange.lowerBound)
        + _base.distance(from: subRange.upperBound, to: _endIndex)
        + newElements.count
      _base.replaceSubrange(subRange, with: newElements)
      _startIndex = _base.startIndex
      _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
    } else {
      let shouldUpdateStartIndex = subRange.lowerBound == _startIndex
      let lastValidIndex = _base.index(before: subRange.lowerBound)
      let newEndIndexOffset =
        _base.distance(from: subRange.upperBound, to: _endIndex)
        + newElements.count + 1
      _base.replaceSubrange(subRange, with: newElements)
      if shouldUpdateStartIndex {
        _startIndex = _base.index(after: lastValidIndex)
      }
      _endIndex = _base.index(lastValidIndex, offsetBy: newEndIndexOffset)
    }
  }

  @inlinable
  public mutating func insert(_ newElement: Base.Element, at i: Index) {
    // FIXME: swift-3-indexing-model: range check.
    if i == _base.startIndex {
      let newSliceCount = count + 1
      _base.insert(newElement, at: i)
      _startIndex = _base.startIndex
      _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
    } else {
      let shouldUpdateStartIndex = i == _startIndex
      let lastValidIndex = _base.index(before: i)
      let newEndIndexOffset = _base.distance(from: i, to: _endIndex) + 2
      _base.insert(newElement, at: i)
      if shouldUpdateStartIndex {
        _startIndex = _base.index(after: lastValidIndex)
      }
      _endIndex = _base.index(lastValidIndex, offsetBy: newEndIndexOffset)
    }
  }

  @inlinable
  public mutating func insert<S>(contentsOf newElements: S, at i: Index)
  where S: Collection, S.Element == Base.Element {
    // FIXME: swift-3-indexing-model: range check.
    if i == _base.startIndex {
      let newSliceCount = count + newElements.count
      _base.insert(contentsOf: newElements, at: i)
      _startIndex = _base.startIndex
      _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
    } else {
      let shouldUpdateStartIndex = i == _startIndex
      let lastValidIndex = _base.index(before: i)
      let newEndIndexOffset =
        _base.distance(from: i, to: _endIndex)
        + newElements.count + 1
      _base.insert(contentsOf: newElements, at: i)
      if shouldUpdateStartIndex {
        _startIndex = _base.index(after: lastValidIndex)
      }
      _endIndex = _base.index(lastValidIndex, offsetBy: newEndIndexOffset)
    }
  }

  @inlinable
  public mutating func remove(at i: Index) -> Base.Element {
    // FIXME: swift-3-indexing-model: range check.
    if i == _base.startIndex {
      let newSliceCount = count - 1
      let result = _base.remove(at: i)
      _startIndex = _base.startIndex
      _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
      return result
    } else {
      let shouldUpdateStartIndex = i == _startIndex
      let lastValidIndex = _base.index(before: i)
      let newEndIndexOffset = _base.distance(from: i, to: _endIndex)
      let result = _base.remove(at: i)
      if shouldUpdateStartIndex {
        _startIndex = _base.index(after: lastValidIndex)
      }
      _endIndex = _base.index(lastValidIndex, offsetBy: newEndIndexOffset)
      return result
    }
  }

  @inlinable
  public mutating func removeSubrange(_ bounds: Range<Index>) {
    // FIXME: swift-3-indexing-model: range check.
    if bounds.lowerBound == _base.startIndex {
      let newSliceCount =
        count - _base.distance(from: bounds.lowerBound, to: bounds.upperBound)
      _base.removeSubrange(bounds)
      _startIndex = _base.startIndex
      _endIndex = _base.index(_startIndex, offsetBy: newSliceCount)
    } else {
      let shouldUpdateStartIndex = bounds.lowerBound == _startIndex
      let lastValidIndex = _base.index(before: bounds.lowerBound)
      let newEndIndexOffset =
          _base.distance(from: bounds.lowerBound, to: _endIndex)
        - _base.distance(from: bounds.lowerBound, to: bounds.upperBound)
        + 1
      _base.removeSubrange(bounds)
      if shouldUpdateStartIndex {
        _startIndex = _base.index(after: lastValidIndex)
      }
      _endIndex = _base.index(lastValidIndex, offsetBy: newEndIndexOffset)
    }
  }
}

extension Slice: Sendable
where Base: Sendable, Base.Index: Sendable { }
*/
