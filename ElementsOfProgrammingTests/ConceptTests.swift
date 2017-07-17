//
//  ConceptTests.swift
//  ElementsOfProgrammingTests
//

import XCTest

class Concept {
    
    // MARK: Chapter 1
    
    static func regular<T: Regular>(x: T) {
        // Default constructor (not really invoked until an object is initialized in Swift)
        var y: T
        
        // Equality
        XCTAssert(x == x)
        
        // Assignment
        y = x
        XCTAssert(y == x)
        
        // Copy constructor
        let xCopy = x
        XCTAssert(xCopy == x)
        
        // Default total ordering
        XCTAssert(!less(x: x, y: x))
        
        // Underlying type
        XCTAssert(type(of: x) == T.self)
        
        // Destructor
    }
    
    static func totallyOrdered<T: TotallyOrdered>(x0: T, x1: T) {
        // Precondition: x0 < x1
        
        XCTAssert(x0 != x1)
        XCTAssert(!(x0 == x1))
        
        // Natural total ordering
        XCTAssert(!(x0 < x0))
        XCTAssert(x0 < x1)
        XCTAssert(x1 > x0)
        XCTAssert(x0 <= x1)
        XCTAssert(x1 >= x0)
        XCTAssert(!(x1 < x0))
        XCTAssert(!(x0 > x1))
        XCTAssert(!(x1 <= x0))
        XCTAssert(!(x0 >= x1))
    }
    
    // MARK: Chapter 2
    
    static func transformation<DomainF: Regular>(f: Transformation<DomainF>, x: DomainF) {
        typealias CodomainF = DomainF
        typealias X = DomainF
        typealias Y = CodomainF
        // X == Y
        var y = x
        XCTAssert(x == y)
        y = f(y)
        typealias N = DistanceType
        var n = N(1)
    }
    
    static func unaryPredicate<DomainP: Regular>(p: UnaryPredicate<DomainP>, x: DomainP) {
        typealias X = DomainP
        var x0: X, x1: X
        if p(x) {
            x0 = x
        } else {
            x1 = x
        }
    }
    
    // MARK: Chapter 3
    
    static func binaryOperation<DomainOp: Regular>(op: BinaryOperation<DomainOp>, x: DomainOp) {
        typealias CodomainOp = DomainOp
        typealias X = DomainOp
        typealias Y = CodomainOp
        var y = x
        XCTAssert(x == y)
        y = op(x, x)
    }
    
    static func integer(n: Integer)  {
        // TODO: Implement
        typealias I = Integer
        let k = I(11)
        Concept.regular(x: n)
        var m: I
        m = n + k
        m = n + k
        m = m - k
        m = m * k
        m = m / k
        m = m % k
        m = I(0) // ensure m < k
        Concept.totallyOrdered(x0: m, x1: k)
        m = n.successor()
        m = n.predecessor()
        m = m.twice()
        m = m.halfNonnegative()
        m = m.binaryScaleDownNonnegative(k: I(1))
        m = m.binaryScaleUpNonnegative(k: I(1))
        let bp = m.positive();
        let bn = m.negative();
        XCTAssert(!(bp && bn));
        let bz = m.zero();
        XCTAssert(bz && !(bn || bp) || !bz && (bn || bp));
        let b1 = m.one();
        XCTAssert(!(bz && b1));
        XCTAssert(!b1 || bp);
        let be = m.even();
        let bo = m.odd();
        XCTAssert(be != bo);
    }
}
