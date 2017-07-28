//
//  Drivers.swift
//  ElementsOfProgramming
//

import EOP

func logFunc(functionName: String = #function) {
    print("\(functionName)")
}

func outputOrbitStructure<DomainFP: Distance & Regular>(x: DomainFP, f: Transformation<DomainFP>, p: UnaryPredicate<DomainFP>) {
    let t = orbitStructure(x: x, f: f, p: p)
    if !p(t.m2) {
        print("terminating with h-1 = \(t.m0) and terminal point \(t.m2)")
    } else if t.m2 == x {
        print("circular with collision point \(collisionPoint(x: x, f: f, p: p)) and c-1 = \(t.m1)")
    } else {
        print("rho-shaped with collision point \(collisionPoint(x: x, f: f, p: p)) and")
        print("h = \(t.m0) and c-1 = \(t.m1) and connection point \(t.m2)")
    }
    print("")
}

func additiveCongruentialTransformation(modulus: Int, index: Int) -> ((Int) -> Int) {
    return { x in (x + index) % modulus }
}

func alwaysDefined<T>() -> ((T) -> Bool) {
    return { _ in return true }
}

func testAdditiveCongruentialTransformation(modulus: Int, index: Int) {
    print("Running testAdditiveCongruentialTransformation")
    let f = additiveCongruentialTransformation(modulus: modulus, index: index)
    outputOrbitStructure(x: index,
                         f: f,
                         p: alwaysDefined())
}
