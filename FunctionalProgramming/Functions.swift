import Foundation

//Define the function inverse :: Float -> Maybe Float that given a number, returns the inverse if it is defined, or Nothing if it is not
func inverse(_ f: Float) -> Maybe<Float> {
    return f == 0 ? .Nothing : .Just(1/f)
}

//Define the function toInt :: Either Int Bool -> Int that converts to Int an expression that may be Int or Bool (it returns 0 for False or 1 for True)
func toInt(_ e: Either<Int, Bool>) -> Int {
    switch e {
    case .Left(let l):
        return l
    case .Right(let r):
        return r ? 1 : 0
    }
}

//Define the function clean :: string -> string -> string that removes the characters in the second string that appear in the first string. For example, clean("susto", "puerta") returns "pera"
func clean(_ s1: String, _ s2: String) -> String {
    if s1.isEmpty { return s2 }
    if s2.isEmpty { return s2 }
    return contains(s2.first!, s: s1) ? clean(s1, String(s2.dropFirst())) : s2.first! + clean(s1, String(s2.dropFirst()))
}

func contains(_ c: Character, s: String) -> Bool {
    if s.isEmpty { return false }
    return s.first! == c || contains(c, s: String(s.dropFirst()))
}

// Define the function averageDiff :: [Float] -> [Float] that given a list of numbers, it returns the difference of each of them with the average. For example, averageDiff([2, 3, 4]) returns [-1, 0, 1]
func averageDiff(_ l: [Float]) -> [Float] {
    return l.map({$0 - average(l)})
}

func average(_ l: [Float]) -> Float {
    if l.isEmpty { return 0 }
    return sum(l) / Float(l.count)
}

func sum(_ l: [Float]) -> Float {
    if l.isEmpty { return 0 }
    return l.first! + sum(Array(l.dropFirst()))
}

// Define allEquals :: [Int] -> Bool that given a list of numbers, it returns true if they are all equals
func allEquals(_ l: [Int]) -> Bool {
    if l.count <= 1 { return true }
    return l.first! == l.dropFirst().first! && allEquals(Array(l.dropFirst()))
}

// Define isEmpty :: BinaryTree -> Bool that says if a tree is empty or not
func isEmpty<T>(_ bt: BinaryTree<T>) -> Bool {
    switch bt {
    case .Nil:
        return true
    case .Bin(_, _, _):
        return false
    }
}

// Define negation :: BinaryTree -> BinaryTree that takes a binary tree of Int and returns another binary tree with all the elements negated
func negation(_ bt: BinaryTree<Int>) -> BinaryTree<Int> {
    switch bt {
    case .Nil:
        return .Nil
    case .Bin(let left, let r, let right):
        return .Bin(negation(left), -r, negation(right))
    }
}

// Define product :: BinaryTree -> Int that takes a binary tree
func product(_ bt: BinaryTree<Int>) -> Int {
    switch bt {
    case .Nil:
        return 1
    case .Bin(let left, let r, let right):
        return r * product(left) * product(right)
    }
}

// Currify the function max :: Int -> Int -> Int that takes 2 arguments and returns the max of both
func max(_ x: Int) -> (Int) -> Int {
    return { x > $0 ? x : $0  }
}

// Currify the function normVector(x, y) defined as sqrt(x^2 + y^2)
func normVector(_ x: Double) -> (Double) -> Double {
    return { sqrt(x*x + $0*$0) }
}

// Define the function curry, that takes given a function of two arguments, it returns the equivalent, currified
func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> ((A) -> ((B) -> C)) {
    return { (p1) -> ((B) -> C) in return { (p2) -> C in f(p1, p2) } }
}

// Define the function uncurry, that given a currified version, it returns the not currified version
func uncurry<A, B, C>(_ f: @escaping (A) -> ((B) -> C)) -> ((A, B) -> C) {
    return { (p1, p2) -> C in f(p1)(p2) }
}

// Define the function DivideAndConquer :: (a -> Bool)  It determines if the entry is trivial
//                                      -> (a -> b)     It solves the trivial case
//                                      -> (a -> [a])   It divides the problem into subproblems
//                                      -> ([b] -> b)   It combines the results
//                                      -> a            Entry
//                                      -> b            Result
func divideAndConquer<A, B>(trivial: ((A) -> Bool), solve: ((A) -> B), split: ((A) -> [A]), combine: (([B]) -> B), x: A) -> B {
    if trivial(x) { return solve(x) }
    let subproblems = split(x).map({ (subproblem) -> B in
        divideAndConquer(trivial: trivial, solve: solve, split: split, combine: combine, x: subproblem)
    })
    return combine(subproblems)
}

// Implement mergeSort :: [A] -> [A] using DivideAndConquer
func mergeSort<A: Comparable>(_ list: [A]) -> [A] {
    let trivial = { (e: [A]) in e.count <= 1 }
    let solve = { (e: [A]) in e }
    let split = { (e: [A]) in [Array(e[0..<e.count/2]), Array(e[e.count/2..<e.count])] }
    let combine = { (e: [[A]]) -> [A] in merge(e[0], e[1]) }
    return divideAndConquer(trivial: trivial, solve: solve, split: split, combine: combine, x: list)
}

func merge<A: Comparable>(_ l1: [A], _ l2: [A]) -> [A] {
    if l1.isEmpty { return l2 }
    if l2.isEmpty { return l1 }
    if l1.first! < l2.first! {
        return [l1.first!] + merge(Array(l1.dropFirst()), l2)
    }
    return [l2.first!] + merge(l1, Array(l2.dropFirst()))
}

// Implement the function pow(a, b) that returns a^b using divideAndConquer
func pow(_ a: Int, _ b: Int) -> Int {
    let trivial = { (e: Int, p: Int) in p == 0 || p == 1 }
    let solve = { (e: Int, p: Int) in e == 0 ? 1 : e }
    let split = { (e: Int, p: Int) in p % 2 == 0 ? [(e, p/2), (e, p/2)] : [(e, p/2), (e, p/2), (e, 1)] }
    let combine = { (e: [Int]) -> Int in e.reduce(1, { (r, i) -> Int in r * i }) }
    return divideAndConquer(trivial: trivial, solve: solve, split: split, combine: combine, x: (a, b))
}

// Recursion scheme on lists

func foldr<A, B>(_ f: (A, B) -> B, _ z: B, _ l: [A]) -> B {
    if l.isEmpty { return z }
    return f(l.first!, foldr(f, z, Array(l.dropFirst())))
}

func foldl<A, B>(_ f: (B, A) -> B, _ z: B, _ l: [A]) -> B {
    if l.isEmpty { return z }
    return foldl(f, f(z, l.first!), Array(l.dropFirst()))
}

func longitude<A>(_ l: [A]) -> Int {
    return foldr({$1 + 1}, 0, l)
}

func product(_ l: [Int]) -> Int {
    return foldr({$0 * $1}, 1, l)
}

func concat<A>(_ l: [[A]]) -> [A] {
    return foldr({ $0 + $1 }, [], l)
}

func all<A>(_ f: (A) -> Bool, _ l: [A] ) -> Bool {
    return foldr({ f($0) && $1 }, true, l)
}

func map<A, B>(_ f: (A) -> B, _ l: [A]) -> [B] {
    return foldr({ [f($0)] + $1 }, [], l)
}

func filter<A>(_ f: (A) -> Bool, _ l: [A]) -> [A] {
    return foldr({ (f($0) ? [$0] : []) + $1 }, [], l)
}
