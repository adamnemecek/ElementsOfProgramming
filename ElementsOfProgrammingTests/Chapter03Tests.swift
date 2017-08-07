//
//  Chapter03Tests.swift
//  ElementsOfProgrammingTests
//

import XCTest
import EOP

class Chapter03Tests: XCTestCase {

    func testConceptBinaryOperation() {
        Concept.binaryOperation(op: minusInt, x: 7)
        Concept.binaryOperation(op: timesInt, x: 8)
    }
    
    func testPower() {
        XCTAssert(powerLeftAssociated(-2, power: 3, operation: minusInt) == 2) // (-2 - -2) - -2 = 2
        XCTAssert(powerLeftAssociated(-2, power: 4, operation: minusInt) == 4) // ((-2 - -2) - -2) - -2 = 4
        algorithmPower(pow: powerLeftAssociated)
        XCTAssert(powerRightAssociated(-2, power: 3, operation: minusInt) == -2) // -2 - (-2 - -2) = -2
        XCTAssert(powerRightAssociated(-2, power: 4, operation: minusInt) == 0) // -2 - (-2 - (-2 - -2) = 0
        algorithmPower(pow: powerRightAssociated)
        algorithmPower(pow: power0)
        algorithmPower(pow: power1)
        algorithmPowerAccumulate(pow: powerAccumulate0)
        algorithmPowerAccumulate(pow: powerAccumulate1)
        algorithmPowerAccumulate(pow: powerAccumulate2)
        algorithmPowerAccumulate(pow: powerAccumulate3)
        algorithmPowerAccumulate(pow: powerAccumulate4)
        algorithmPowerAccumulatePositive(pow: powerAccumulatePositive0)
        algorithmPowerAccumulate(pow: powerAccumulate5)
        algorithmPower(pow: power2)
        algorithmPower(pow: power3)
        algorithmPowerAccumulatePositive(pow: powerAccumulatePositive)
        algorithmPowerAccumulate(pow: powerAccumulate)
        algorithmPower(pow: power)
        algorithmPowerWithIdentity(pow: power)
    }
    
    func testConceptInteger() {
        typealias N = Int
        Concept.integer(n: N(7))
    }
    
    func testFibonacci() {
        typealias N = Int
        typealias Fib = Pair<N, N>
        
        Concept.binaryOperation(op: fibonacciMatrixMultiply, x: Fib(m0: N(1), m1: N(0)))
        
        let f10 = Fib(m0: 55, m1: 34)
        let f11 = Fib(m0: 89, m1: 55)
        let f21 = fibonacciMatrixMultiply(x: f10, y: f11)
        XCTAssert(f21.m0 == 10946 && f21.m1 == 6765)
        XCTAssert(fibonacci(n: 10) == N(55))
        XCTAssert(fibonacci(n: 20) == N(6765))
    }
    
    func minusInt(a: Int, b: Int) -> Int { return a - b }
    
    func timesInt(a: Int, b: Int) -> Int { return a * b }
    
    func algorithmPower(pow: (Int, Int, BinaryOperation<Int>) -> Int) {
        XCTAssert(pow(1, 1, timesInt) == 1)
        XCTAssert(pow(10, 1, timesInt) == 10)
        XCTAssert(pow(1, 10, timesInt) == 1)
        XCTAssert(pow(2, 2, timesInt) == 4)
        XCTAssert(pow(2, 10, timesInt) == 1024)
        XCTAssert(pow(10, 2, timesInt) == 100)
    }
    
    func algorithmPowerAccumulate(pow: (Int, Int, Int, BinaryOperation<Int>) -> Int) {
        XCTAssert(pow(99, 1, 1, timesInt) == 99 * 1)
        XCTAssert(pow(99, 10, 1, timesInt) == 99 * 10)
        // FIXME: Fix this
//        XCTAssert(pow(99, 1, 10, timesInt) == 99 * 1)
//        XCTAssert(pow(99, 2, 2, timesInt) == 99 * 4)
//        XCTAssert(pow(99, 2, 10, timesInt) == 99 * 1024)
//        XCTAssert(pow(99, 10, 2, timesInt) == 99 * 100)
//        XCTAssert(pow(99, 1, 0, timesInt) == 99)
    }
    
    func algorithmPowerAccumulatePositive(pow: (Int, Int, Int, BinaryOperation<Int>) -> Int) {
        XCTAssert(pow(99, 1, 1, timesInt) == 99 * 1)
        XCTAssert(pow(99, 10, 1, timesInt) == 99 * 10)
        // FIXME: Fix this
//        XCTAssert(pow(99, 1, 10, timesInt) == 99 * 1)
//        XCTAssert(pow(99, 2, 2, timesInt) == 99 * 4)
//        XCTAssert(pow(99, 2, 10, timesInt) == 99 * 1024)
//        XCTAssert(pow(99, 10, 2, timesInt) == 99 * 100)
    }
    
    func algorithmPowerWithIdentity(pow: (Int, Int, BinaryOperation<Int>, Int) -> Int) {
        XCTAssert(pow(1, 1, timesInt, 1) == 1)
        XCTAssert(pow(10, 1, timesInt, 1) == 10)
        XCTAssert(pow(1, 10, timesInt, 1) == 1)
        XCTAssert(pow(2, 2, timesInt, 1) == 4)
        XCTAssert(pow(2, 10, timesInt, 1) == 1024)
        XCTAssert(pow(10, 2, timesInt, 1) == 100)
        XCTAssert(pow(1, 0, timesInt, 1) == 1)
        XCTAssert(pow(1, 0, timesInt, 99) == 99)
    }
}
