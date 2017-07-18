//
//  Chapter04.swift
//  ElementsOfProgramming
//

// Exercise 4.1: Give an example of a relation that is neither strict nor reflexive
// Exercise 4.2: Give an example of a symmetric relation that is not transitive
// Exercise 4.3: Give an example of a symmetric relation that is not reflexive

func complement<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { x, y in
        return !r(x, y)
    }
}

func converse<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { x, y in
        return r(y, x)
    }
}

func complementOfConverse<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { a, b in
        return !r(b, a)
    }
}

func symmetricComplement<DomainR: Regular>(r: @escaping Relation<DomainR>) -> Relation<DomainR> {
    return { a, b in
        return !r(a,b) && !r(b, a)
    }
}

func select02<DomainR: Regular>(a: DomainR, b: DomainR, r: Relation<DomainR>) -> DomainR {
    // Precondition: $\func{weak\_ordering}(r)$
    if r(b, a) { return b }
    return a
}

func select12<DomainR: Regular>(a: DomainR, b: DomainR, r: Relation<DomainR>) -> DomainR {
    // Precondition: $\func{weak\_ordering}(r)$
    if r(b, a) { return a }
    return b
}

func select03<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, r: Relation<DomainR>) -> DomainR {
    return select02(a: select02(a: a, b: b, r: r), b: c, r: r)
}

func select23<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, r: Relation<DomainR>) -> DomainR {
    return select12(a: select12(a: a, b: b, r: r), b: c, r: r)
}

func select13ab<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, r: Relation<DomainR>) -> DomainR {
    if !r(c, b) { return b }          // $a$, $b$, $c$ are sorted
    return select12(a: a, b: c, r: r) // $b$ is not the median
}

func select13<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, r: Relation<DomainR>) -> DomainR {
    if r(b, a) { return select13ab(a: b, b: a, c: c, r: r) }
    return select13ab(a: a, b: b, c: c, r: r)
}

func select14abcd<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if r(c, a) { return select02(a: a, b: d, r: r) }
    return select02(a: b, b: c, r: r)
}

func select14ab<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if r(d, c) { return select14abcd(a: a, b: b, c: d, d: c, r: r) }
    return select14abcd(a: a, b: b, c: c, d: d, r: r)
}

func select14<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if r(b, a) { return select14ab(a: b, b: a, c: c, d: d, r: r) }
    return select14ab(a: a, b: b, c: c, d: d, r: r)
}

// Exercise 4.4: select_2_4


// Order selection procedures with stability indices

func compareStrictOrReflexiveTrue<DomainR: Regular>(a: DomainR, b: DomainR, r: Relation<DomainR>) -> Bool {
    return r(a, b)
}

func compareStrictOrReflexiveFalse<DomainR: Regular>(a: DomainR, b: DomainR, r: Relation<DomainR>) -> Bool {
    return !r(b, a) // $\func{complement\_of\_converse}_r(a, b)$
}

func compareStrictOrReflexive<DomainR: Regular>(_ flag: Bool) -> (DomainR, DomainR, Relation<DomainR>) -> Bool {
    if flag {
        return compareStrictOrReflexiveTrue
    } else {
        return compareStrictOrReflexiveFalse
    }
}

func select02<DomainR: Regular>(ia: Int, ib: Int, a: DomainR, b: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ib)(b, a, r) { return b }
    return a
}

func select12<DomainR: Regular>(ia: Int, ib: Int, a: DomainR, b: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ib)(b, a, r) { return a }
    return b
}

func select14abcd<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ic)(c, a, r) {
        return select02(ia: ia, ib: id, a: a, b: d, r: r)
    }
    return select02(ia: ib, ib: ic, a: b, b: c, r: r)
}

func select14ab<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ic < id)(d, c, r) {
        return select14abcd(ia: ia, ib: ib, ic: id, id: ic, a: a, b: b, c: d, d: c, r: r)
    }
    return select14abcd(ia: ia, ib: ib, ic: ic, id: id, a: a, b: b, c: c, d: d, r: r)
}

func select14<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ib)(b, a, r) {
        return select14ab(ia: ib, ib: ia, ic: ic, id: id, a: b, b: a, c: c, d: d, r: r)
    }
    return select14ab(ia: ia, ib: ib, ic: ic, id: id, a: a, b: b, c: c, d: d, r: r)
}

func select25abcd<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, ie: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ic)(c, a, r) {
        return select14ab(ia: ia, ib: ib, ic: id, id: ie, a: a, b: b, c: d, d: e, r: r)
    }
    return select14ab(ia: ic, ib: id, ic: ib, id: ie, a: c, b: d, c: b, d: e, r: r)
}

func select25ab<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, ie: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ic < id)(d, c, r) {
        return select25abcd(ia: ia, ib: ib, ic: id, id: ic, ie: ie, a: a, b: b, c: d, d: c, e: e, r: r)
    }
    return select25abcd(ia: ia, ib: ib, ic: ic, id: id, ie: ie, a: a, b: b, c: c, d: d, e: e, r: r)
}

func select25<DomainR: Regular>(ia: Int, ib: Int, ic: Int, id: Int, ie: Int, a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR, r: Relation<DomainR>) -> DomainR {
    if compareStrictOrReflexive(ia < ib)(b, a, r) {
        return select25abcd(ia: ib, ib: ia, ic: ic, id: id, ie: ie, a: b, b: a, c: c, d: d, e: e, r: r)
    }
    return select25abcd(ia: ia, ib: ib, ic: ic, id: id, ie: ie, a: a, b: b, c: c, d: d, e: e, r: r)
}

// Exercise 4.5. Find an algorithm for median of 5 that does slightly fewer comparisons
// on average


func median5<DomainR: Regular>(a: DomainR, b: DomainR, c: DomainR, d: DomainR, e: DomainR, r: Relation<DomainR>) -> DomainR {
    return select25(ia: 0, ib: 1, ic: 2, id: 3, ie: 4, a: a, b: b, c: c, d: d, e: e, r: r)
}


// Exercise 4.6. Prove the stability of every order selection procedure in this section
// Exercise 4.7. Verify the correctness and stability of every order selection procedure
// in this section by exhaustive testing

// Natural total ordering

func less<T: TotallyOrdered>(x: T, y: T) -> Bool {
    return x < y
}

func minSelect<T: TotallyOrdered>(a: T, b: T) -> T {
    return select02(a: a, b: b, r: less)
}

func maxSelect<T: TotallyOrdered>(a: T, b: T) -> T {
    return select12(a: a, b: b, r: less)
}


// Clusters of related procedures: equality and ordering

// !=
// >
// <=
// >=


// Exercise 4.8: Rewrite the algorithms in this chapter using three-valued comparison