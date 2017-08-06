//
//  Chapter06.swift
//  ElementsOfProgramming
//

import EOP

func increment<I: Iterator>(x: inout I) throws {
    // Precondition: successor(x) is defined
    guard let s = x.iteratorSuccessor else { throw EOPError.noSuccessor }
    x = s
}

// See ForwardIterator protocol in Concepts.swift
//
//public func +<I: Iterator>(lhs: I, rhs: DistanceType) -> I {
//    var f = lhs, n = rhs
//    // Precondition: weak_range(f, n)
//    assert(n >= 0)
//    while n != 0 {
//        n = n.predecessor()
//        f = f.iteratorSuccessor
//    }
//    return f
//}
//
//public func -<I: Iterator>(lhs: I, rhs: I) -> DistanceType {
//    let l = lhs
//    var f = rhs
//    // Precondition: bounded_range(f, l)
//    var n = DistanceType(0)
//    while f != l {
//        n = n.successor()
//        f = f.iteratorSuccessor
//    }
//    return n
//}

func forEach<
    I: Readable & Iterator,
    P: UnaryProcedure
>(
    f: I, l: I,
    proc: P
) -> P where P.UnaryProcedureType == I.Source {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    while f != l {
        proc.call(f.source!)
        guard let s = f.iteratorSuccessor else { return proc }
        f = s
    }
    return proc
}

func find<I: Readable & Iterator>(f: I, l: I, x: I.Source) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    while f != l && f.source! != x {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

func findNot<I: Readable & Iterator>(f: I, l: I, x: I.Source) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    while f != l && f.source! == x {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

func findIf<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    while f != l && !p(f.source!) {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

func findIfNot<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    while f != l && p(f.source!) {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

// Exercise 6.1: quantifier functions

func all<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    return l == findIfNot(f: f, l: l, p: p)
}

func none<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    return l == findIf(f: f, l: l, p: p)
}

func notAll<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    return !all(f: f, l: l, p: p)
}

func some<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    return !none(f: f, l: l, p: p)
}

func countIf<
    I: Readable & Iterator,
    J: Iterator
>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>, j: J
) -> J? {
    var f = f, j = j
    // Precondition: readable_bounded_range(f, l)
    while f != l {
        if p(f.source!) {
            guard let s = j.iteratorSuccessor else { return nil }
            j = s
        }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return j
}

// Exercise 6.2: implement count_if using for_each

func countIf<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> DistanceType? {
    // Precondition: readable_bounded_range(f, l)
    return countIf(f: f, l: l, p: p, j: DistanceType(0))
}

func count<
    I: Readable & Iterator,
    J: Iterator
>(
    f: I, l: I,
    x: I.Source,
    j: J
) -> J? {
    var f = f, j = j
    // Precondition: readable_bounded_range(f, l)
    while f != l {
        if f.source! == x {
            guard let s = j.iteratorSuccessor else { return nil }
            j = s
        }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return j
}

func count<I: Readable & Iterator>(
    f: I, l: I,
    x: I.Source
) -> DistanceType? {
    // Precondition: readable_bounded_range(f, l)
    return count(f: f, l: l, x: x, j: DistanceType(0))
}

func countNot<
    I: Readable & Iterator,
    J: Iterator
>(
    f: I, l: I,
    x: I.Source,
    j: J
) -> J? {
    var f = f, j = j
    // Precondition: readable_bounded_range(f, l)
    while f != l {
        if f.source! != x {
            guard let s = j.iteratorSuccessor else { return nil }
            j = s
        }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return j
}

func countNot<I: Readable & Iterator>(
    f: I, l: I,
    x: I.Source
) -> DistanceType? {
    // Precondition: readable_bounded_range(f, l)
    return countNot(f: f, l: l, x: x, j: DistanceType(0))
}

func countIfNot<
    I: Readable & Iterator,
    J: Iterator
>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>,
    j: J
) -> J? {
    var f = f, j = j
    // Precondition: readable_bounded_range(f, l)
    while f != l {
        if !p(f.source!) {
            guard let s = j.iteratorSuccessor else { return nil }
            j = s
        }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return j
}

func countIfNot<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> DistanceType? {
    // Precondition: readable_bounded_range(f, l)
    return countIfNot(f: f, l: l, p: p, j: DistanceType(0))
}

func reduceNonempty<
    I: Iterator,
    DomainOp: Regular
>(
    f: I, l: I,
    op: BinaryOperation<DomainOp>,
    fun: UnaryFunction<I, DomainOp>
) -> DomainOp? {
    var f = f
    // Precondition: bounded_range(f, l) ∧ f ≠ l
    // Precondition: partially_associative(op)
    // Precondition: (∀x ∈ [f, l)), fun(x) is defined
    var r = fun(f)
    guard let fs = f.iteratorSuccessor else { return nil }
    f = fs
    while f != l {
        r = op(r, fun(f))
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return r
}

func reduceNonempty<I: Readable & Iterator>(
    f: I, l: I,
    op: BinaryOperation<I.Source>
) -> I.Source? {
    var f = f
    // Precondition: readable_bounded_range(f, l) ∧ f ≠ l
    // Precondition: partially_associative(op)
    var r = f.source!
    guard let fs = f.iteratorSuccessor else { return nil }
    f = fs
    while f != l {
        r = op(r, f.source!)
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return r
}

func reduce<
    I: Iterator,
    DomainOp: Regular
>(
    f: I, l: I,
    op: BinaryOperation<DomainOp>,
    fun: UnaryFunction<I, DomainOp>,
    z: DomainOp
) -> DomainOp? {
    // Precondition: bounded_range(f, l)
    // Precondition: partially_associative(op)
    // Precondition: (∀x ∈ [f, l)), fun(x) is defined
    guard f != l else { return z }
    return reduceNonempty(f: f, l: l, op: op, fun: fun)
}

func reduce<I: Readable & Iterator>(
    f: I, l: I,
    op: BinaryOperation<I.Source>,
    z: I.Source
) -> I.Source? {
    // Precondition: readable_bounded_range(f, l)
    // Precondition: partially_associative(op)
    guard f != l else { return z }
    return reduceNonempty(f: f, l: l, op: op)
}

func reduceNonzeroes<
    I: Iterator,
    DomainOp: Regular
>(
    f: I, l: I,
    op: BinaryOperation<DomainOp>,
    fun: UnaryFunction<I, DomainOp>,
    z: DomainOp
) -> DomainOp? {
    var f = f
    // Precondition: bounded_range(f, l)
    // Precondition: partially_associative(op)
    // Precondition: (∀x ∈ [f, l)), fun(x) is defined
    var x: DomainOp
    repeat {
        guard f != l else { return z }
        x = fun(f)
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    } while x == z
    
    while f != l {
        let y = fun(f)
        if y != z { x = op(x, y) }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return x
}

func reduceNonzeroes<I: Readable & Iterator>(
    f: I, l: I,
    op: BinaryOperation<I.Source>,
    z: I.Source
) -> I.Source? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    // Precondition: partially_associative(op)
    var x: I.Source
    repeat {
        guard f != l else { return z }
        x = f.source!
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    } while x == z
    
    while f != l {
        let y = f.source!
        if y != z { x = op(x, y) }
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return x
}

func reduce<I: Readable & Iterator>(
    f: I, l: I
) -> I.Source?
where I.Source : AdditiveMonoid {
    // Precondition: readable_bounded_range(f, l)
    typealias T = I.Source
    return reduce(f: f, l: l, op: plus, z: T.additiveIdentity)
}

// FIXME: Figure out a way to make this work
//func forEachN<I: Readable & Iterator>(
//    f: I, n: DistanceType,
//    proc: UnaryProcedure<I.Source>
//) -> Pair<UnaryProcedure<I.Source>, I> {
//    var f = f, n = n
//    // Precondition: readable_weak_range(f, n)
//    while n != 0 {
//        n = n.predecessor()
//        proc(f.source()!)
//        f = f.successor!
//    }
//    return Pair(proc, f)
//}

func findN<I: Readable & Iterator>(
    f: I,
    n: DistanceType,
    x: I.Source
) -> Pair<I, DistanceType>? {
    var f = f, n = n
    // Precondition: readable_weak_range(f, n)
    while n != 0 && f.source! != x {
        n = n.predecessor()
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return Pair(m0: f, m1: n)
}


// Exercise 6.3: implement variations taking a weak range instead of a bounded range
// of all the versions of find, quantifiers, count, and reduce


func findIfUnguarded<I: Readable & Iterator>(
    f: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var f = f
    // Precondition: (∃l), readable_bounded_range(f, l) ∧ some(f, l, p)
    while !p(f.source!) {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
    // Postcondition: p(source(f))
}

func findIfNotUnguarded<I: Readable & Iterator>(
    f: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var f = f
    // Let l be the end of the implied range starting with f
    // Precondition: readable_bounded_range(f, l) ∧ not_all(f, l, p)
    while p(f.source!) {
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

public func findMismatch<
    I0: Readable & Iterator,
    I1: Readable & Iterator
>(
    f0: I0, l0: I0,
    f1: I1, l1: I1,
    r: Relation<I0.Source>
) -> Pair<I0, I1>?
where I0.Source == I1.Source {
    var f0 = f0, f1 = f1
    // Precondition: readable_bounded_range(f0, l0)
    // Precondition: readable_bounded_range(f1, l1)
    while f0 != l0 && f1 != l1 && r(f0.source!, f1.source!) {
        guard let f0s = f0.iteratorSuccessor,
              let f1s = f1.iteratorSuccessor else { return nil }
        f0 = f0s
        f1 = f1s
    }
    return Pair(m0: f0, m1: f1)
}

func findAdjacentMismatch<I: Readable & Iterator>(
    f: I, l: I,
    r: Relation<I.Source>
) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    guard f != l else { return l }
    var x = f.source!
    while f != l && r(x, f.source!) {
        x = f.source!
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    }
    return f
}

func relationPreserving<I: Readable & Iterator>(
    f: I, l: I,
    r: Relation<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    return l == findAdjacentMismatch(f: f, l: l, r: r)
}

func strictlyIncreasingRange<I: Readable & Iterator>(
    f: I, l: I,
    r: Relation<I.Source>
) -> Bool {
    // Precondition:
    // readable_bounded_range(f, l) ∧ weak_ordering(r)
    return relationPreserving(f: f, l: l, r: r)
}

func increasingRange<I: Readable & Iterator>(
    f: I, l: I,
    r: @escaping Relation<I.Source>
) -> Bool {
    // Precondition:
    // readable_bounded_range(f, l) ∧ weak_ordering(r)
    return relationPreserving(f: f,
                              l: l,
                              r: complementOfConverse(r: r))
}

func partitioned<I: Readable & Iterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> Bool {
    // Precondition: readable_bounded_range(f, l)
    guard let fi = findIf(f: f, l: l, p: p) else { return false }
    return l == findIfNot(f: fi,
                          l: l,
                          p: p)
}


// Exercise 6.6: partitioned_n


func findAdjacentMismatch<I: Readable & ForwardIterator>(
    f: I, l: I,
    r: Relation<I.Source>
) -> I? {
    var f = f
    // Precondition: readable_bounded_range(f, l)
    guard f != l else { return l }
    var t: I
    repeat {
        t = f
        guard let s = f.iteratorSuccessor else { return nil }
        f = s
    } while f != l && r(t.source!, f.source!)
    return f
}

func partitionPointN<I: Readable & ForwardIterator>(
    f: I,
    n: DistanceType,
    p: UnaryPredicate<I.Source>
) -> I? {
    var f = f, n = n
    // Precondition:
    // readable_counted_range(f, n) ∧ partitioned_n(f, n, p)
    while n != 0 {
        let h = n.halfNonnegative()
        guard let m = f.successor(at: h) else { return nil }
        if p(m.source!) {
            n = h
        } else {
            n = n - h.successor()
            guard let s = m.iteratorSuccessor else { return nil }
            f = s
        }
    }
    return f
}

func partitionPoint<I: Readable & ForwardIterator>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    // Precondition:
    // readable_bounded_range(f, l) ∧ partitioned(f, l, p)
    return partitionPointN(f: f, n: l.distance(from: f), p: p)
}

func lowerBoundPredicate<DomainR: Regular>(
    a: DomainR,
    r: @escaping Relation<DomainR>
) -> UnaryPredicate<DomainR> {
    return { x in !r(x, a) }
}

func lowerBoundN<I: Readable & ForwardIterator>(
    f: I,
    n: DistanceType,
    a: I.Source,
    r: @escaping Relation<I.Source>
) -> I? {
    // Precondition:
    // weak_ordering(r) ∧ increasing_counted_range(f, n, r)
    let p = lowerBoundPredicate(a: a, r: r)
    return partitionPointN(f: f, n: n, p: p)
}

func upperBoundPredicate<DomainR: Regular>(
    a: DomainR,
    r: @escaping Relation<DomainR>
) -> UnaryPredicate<DomainR> {
    return { x in r(a, x) }
}

func upperBoundN<I: Readable & ForwardIterator>(
    f: I,
    n: DistanceType,
    a: I.Source,
    r: @escaping Relation<I.Source>
) -> I? {
    // Precondition:
    // weak_ordering(r) ∧ increasing_counted_range(f, n, r)
    let p = upperBoundPredicate(a: a, r: r)
    return partitionPointN(f: f, n: n, p: p)
}


// Exercise 6.7: equal_range

//func -<I: BidirectionalIterator>(
//    l: I,
//    n: DistanceType
//) -> I {
//    var l = l, n = n
//    // Precondition: n ≥ 0 ∧ (∃f ∈ I), (weak_range(f, n) ∧ l = f + n)
//    while n != 0 {
//        n = n.predecessor()
//        l = l.iteratorPredecessor
//    }
//    return l
//}

func findBackwardIf<
    I: Readable & BidirectionalIterator
>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var l = l
    // Precondition: readable_bounded_range(f, l)
    guard var ip = l.iteratorPredecessor else { return nil }
    while l != f && !p(ip.source!) {
        l = ip
        guard let ipp = ip.iteratorPredecessor else { return nil }
        ip = ipp
    }
    return l
}

func findBackwardIfNot<
    I: Readable & BidirectionalIterator
>(
    f: I, l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var l = l
    // Precondition: readable_bounded_range(f, l)
    guard var ip = l.iteratorPredecessor else { return nil }
    while l != f && p(ip.source!) {
        l = ip
        guard let ipp = ip.iteratorPredecessor else { return nil }
        ip = ipp
    }
    return l
}


// Exercise 6.8: optimized find_backward_if


// Exercise 6.9: palindrome predicate


func findBackwardIfUnguarded<
    I: Readable & BidirectionalIterator
>(
    l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var l = l
    // Precondition:
    // (∃f ∈ I), readable_bounded_range(f, l) ∧ some(f, l, p)
    repeat {
        guard let ip = l.iteratorPredecessor else { return nil }
        l = ip
    } while !p(l.source!)
    return l
    // Postcondition: p(source(l))
}

func findBackwardIfNotUnguarded<
    I: Readable & BidirectionalIterator
>(
    l: I,
    p: UnaryPredicate<I.Source>
) -> I? {
    var l = l
    // Precondition:
    // (∃f ∈ I), readable_bounded_range(f, l) ∧ not_all(f, l, p)
    repeat {
        guard let ip = l.iteratorPredecessor else { return nil }
        l = ip
    } while p(l.source!)
    return l
    // Postcondition: ￢p(source(l))
}
