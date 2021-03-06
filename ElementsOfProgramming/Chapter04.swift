//
//  Chapter04.swift
//  ElementsOfProgramming
//

import EOP

// Exercise 4.1: Give an example of a relation that is neither strict nor reflexive
// Exercise 4.2: Give an example of a symmetric relation that is not transitive
// Exercise 4.3: Give an example of a symmetric relation that is not reflexive

func complement<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { x, y in !r(x, y) }
}

func converse<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { x, y in r(y, x) }
}

public func complementOfConverse<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { a, b in !r(b, a) }
}

func symmetricComplement<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { a, b in !r(a,b) && !r(b, a) }
}

func select_0_2<DomainR: Regular>(a: DomainR, b: DomainR, r: Relation<DomainR>) -> DomainR {
    // Precondition: weak_ordering(r)
    guard r(b, a) else { return a }
    return b
}

func select_1_2<DomainR: Regular>(
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    // Precondition: weak_ordering(r)
    guard r(b, a) else { return b }
    return a
}

func select_0_3<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    return select_0_2(a: select_0_2(a: a, b: b, r: r),
                      b: c,
                      r: r)
}

func select_2_3<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    return select_1_2(a: select_1_2(a: a, b: b, r: r),
                      b: c,
                      r: r)
}

func select_1_3_ab<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if !r(c, b) { return b }            // a, b, c are sorted
    return select_1_2(a: a, b: c, r: r) // b is not the median
}

func select_1_3<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if r(b, a) { return select_1_3_ab(a: b, b: a, c: c, r: r) }
    return select_1_3_ab(a: a, b: b, c: c, r: r)
}

func select_1_4_ab_cd<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if r(c, a) { return select_0_2(a: a, b: d, r: r) }
    return select_0_2(a: b, b: c, r: r)
}

func select_1_4_ab<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if r(d, c) { return select_1_4_ab_cd(a: a, b: b, c: d, d: c, r: r) }
    return select_1_4_ab_cd(a: a, b: b, c: c, d: d, r: r)
}

func select_1_4<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if r(b, a) { return select_1_4_ab(a: b, b: a, c: c, d: d, r: r) }
    return select_1_4_ab(a: a, b: b, c: c, d: d, r: r)
}

// Exercise 4.4: select_2_4


// Order selection procedures with stability indices

func compareStrictOrReflexiveTrue<DomainR: Regular>(
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> Bool {
    return r(a, b)
}

func compareStrictOrReflexiveFalse<DomainR: Regular>(
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> Bool {
    return !r(b, a) // complement_of_converse(r(a, b))
}

func compareStrictOrReflexive<DomainR: Regular>(
    _ flag: Bool,
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> Bool {
    if flag {
        return compareStrictOrReflexiveTrue(a: a, b: b, r: r)
    }
    return compareStrictOrReflexiveFalse(a: a, b: b, r: r)
}

func select_0_2<DomainR: Regular>(
    ia: Int, ib: Int,
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ib,
                                a: b,
                                b: a,
                                r: r) { return b }
    return a
}

func select_1_2<DomainR: Regular>(
    ia: Int, ib: Int,
    a: DomainR, b: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ib,
                                a: b,
                                b: a,
                                r: r) { return a }
    return b
}

func select_1_4_ab_cd<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ic,
                                a: c,
                                b: a,
                                r: r) {
        return select_0_2(ia: ia, ib: id,
                          a: a, b: d,
                          r: r)
    }
    return select_0_2(ia: ib, ib: ic,
                      a: b, b: c,
                      r: r)
}

func select_1_4_ab<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ic < id,
                                a: d, b: c,
                                r: r) {
        return select_1_4_ab_cd(ia: ia, ib: ib, ic: id, id: ic,
                                a: a, b: b, c: d, d: c,
                                r: r)
    }
    return select_1_4_ab_cd(ia: ia, ib: ib, ic: ic, id: id,
                            a: a, b: b, c: c, d: d,
                            r: r)
}

func select_1_4<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ib,
                                a: b,
                                b: a,
                                r: r) {
        return select_1_4_ab(ia: ib, ib: ia, ic: ic, id: id,
                             a: b, b: a, c: c, d: d,
                             r: r)
    }
    return select_1_4_ab(ia: ia, ib: ib, ic: ic,
                         id: id, a: a, b: b, c: c, d: d,
                         r: r)
}

func select_2_5_ab_cd<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int, ie: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ic,
                                a: c,
                                b: a,
                                r: r) {
        return select_1_4_ab(ia: ia, ib: ib, ic: id, id: ie,
                             a: a, b: b, c: d, d: e,
                             r: r)
    }
    return select_1_4_ab(ia: ic, ib: id, ic: ib, id: ie,
                         a: c, b: d, c: b, d: e,
                         r: r)
}

func select_2_5_ab<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int, ie: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ic < id,
                                a: d, b: c,
                                r: r) {
        return select_2_5_ab_cd(ia: ia, ib: ib, ic: id, id: ic, ie: ie,
                                a: a, b: b, c: d, d: c, e: e,
                                r: r)
    }
    return select_2_5_ab_cd(ia: ia, ib: ib, ic: ic, id: id, ie: ie,
                            a: a, b: b, c: c, d: d, e: e,
                            r: r)
}

func select_2_5<DomainR: Regular>(
    ia: Int, ib: Int, ic: Int, id: Int, ie: Int,
    a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    if compareStrictOrReflexive(ia < ib,
                                a: b,
                                b: a,
                                r: r) {
        return select_2_5_ab(ia: ib, ib: ia, ic: ic, id: id, ie: ie,
                             a: b, b: a, c: c, d: d, e: e,
                             r: r)
    }
    return select_2_5_ab(ia: ia, ib: ib, ic: ic, id: id, ie: ie,
                         a: a, b: b, c: c, d: d, e: e,
                         r: r)
}

// Exercise 4.5. Find an algorithm for median of 5 that does slightly fewer comparisons
// on average


func median_5<DomainR: Regular>(
    a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR,
    r: Relation<DomainR>
) -> DomainR {
    return select_2_5(ia: 0, ib: 1, ic: 2, id: 3, ie: 4,
                      a: a, b: b, c: c, d: d, e: e,
                      r: r)
}


// Exercise 4.6. Prove the stability of every order selection procedure in this section
// Exercise 4.7. Verify the correctness and stability of every order selection procedure
// in this section by exhaustive testing

// Natural total ordering

public func less<T: Regular>(x: T, y: T) -> Bool {
    return x < y
}

func minSelect<T: Regular>(a: T, b: T) -> T {
    return select_0_2(a: a, b: b, r: less)
}

public func maxSelect<T: Regular>(a: T, b: T) -> T {
    return select_1_2(a: a, b: b, r: less)
}


// Clusters of related procedures: equality and ordering

// !=
// >
// <=
// >=


// Exercise 4.8: Rewrite the algorithms in this chapter using three-valued comparison
