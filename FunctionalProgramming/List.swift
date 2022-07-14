//
//  List.swift
//  FunctionalProgramming
//
//  Created by Sebastian Tleye on 14/07/2022.
//  Copyright © 2022 HumileAnts. All rights reserved.
//

import Foundation
import UIKit

// MARK: List

infix operator +++ : NilCoalescingPrecedence

indirect enum List<Element> {
    case Empty
    case Cons(_ x: Element, _ xs: List<Element>)
}

func +++<Element>(lhs: Element, rhs: List<Element>) -> List<Element> {
    return .Cons(lhs, rhs)
}

extension List where Element: SignedNumeric {
    
    // Define the function averageDiff :: [Float] -> [Float] that given a list of numbers, it returns the difference of each of them with the average. For example, averageDiff([2, 3, 4]) returns [-1, 0, 1]
//    var averageDiff: [Element] {
//        switch self {
//        case .Empty:
//            return 0
//        case .Cons(let x, let xs):
//
//        }
//        return l.map({$0 - average(l)})
//    }

//    var average: Element {
//        let a = self.sum
//        return self.sum / Float(self.size)
//    }

    var size: Int {
        switch self {
        case .Empty:
            return 0
        case .Cons(_ , let xs):
            return 1 + xs.size
        }
    }

    var sum: Element {
        switch self {
        case .Empty:
            return 0
        case .Cons(let x, let xs):
            return x + xs.sum
        }
    }

}
