//
//  Either.swift
//  FunctionalProgramming
//
//  Created by Sebastian Tleye on 14/07/2022.
//  Copyright © 2022 HumileAnts. All rights reserved.
//

import Foundation

// MARK: Either

enum Either<A, B> {
    case Left(A)
    case Right(B)
}

extension Bool {
    func toInt() -> Int {
        return self ? 1 : 0
    }
}

//extension Either where A: SignedInteger, B: Bool {
//
//    //Define the function toInt :: Either Int Bool -> Int that converts to Int an expression that may be Int or Bool (it returns 0 for False or 1 for True)
//    func toInt() -> A {
//        switch self {
//        case .Left(let l):
//            return l
//        case .Right(let r):
//            return r ? 1 : 0
//        }
//    }
//
//}
