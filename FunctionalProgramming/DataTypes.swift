import Foundation

enum Maybe<A> {
    case Nothing
    case Just(A)
}

enum Either<A, B> {
    case Left(A)
    case Right(B)
}

indirect enum BinaryTree<T> {
    case Nil
    case Bin(BinaryTree<T>, T, BinaryTree<T>)
}

indirect enum Polynomial<A> {
    case X
    case Cons(A)
    case Sum(Polynomial<A>, Polynomial<A>)
    case Mult(Polynomial<A>, Polynomial<A>)
}
