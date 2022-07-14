import Foundation

// MARK: Maybe (equivalent to optionals)

enum Maybe<A> {
    case Nothing
    case Just(A)
}

// MARK: Polynomial

indirect enum Polynomial<A> {
    case X
    case Cons(A)
    case Sum(Polynomial<A>, Polynomial<A>)
    case Mult(Polynomial<A>, Polynomial<A>)
}

// MARK: Conj

typealias Conj<A> = (A) -> Bool



// MARK:
