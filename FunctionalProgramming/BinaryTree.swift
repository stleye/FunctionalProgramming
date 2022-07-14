//
//  BinaryTree.swift
//  FunctionalProgramming
//
//  Created by Sebastian Tleye on 14/07/2022.
//  Copyright © 2022 HumileAnts. All rights reserved.
//

import Foundation

// MARK: BinaryTree

indirect enum BinaryTree<T> {
    case Nil
    case Bin(BinaryTree<T>, T, BinaryTree<T>)
}

extension BinaryTree where T: UnsignedInteger {

    // Define isEmpty :: BinaryTree -> Bool that says if a tree is empty or not
    func isEmpty() -> Bool {
        switch self {
        case .Nil:
            return true
        case .Bin(_, _, _):
            return false
        }
    }

    // Define negation :: BinaryTree -> BinaryTree that takes a binary tree of Int and returns another binary tree with all the elements negated
    func negation() -> BinaryTree<T> {
        switch self {
        case .Nil:
            return .Nil
        case .Bin(let left, let r, let right):
            return .Bin(left.negation(), -1 * r, right.negation())
        }
    }

    // Define product :: BinaryTree -> Int that takes a binary tree
    func product() -> T {
        switch self {
        case .Nil:
            return 1
        case .Bin(let left, let r, let right):
            return r * left.product() * right.product()
        }
    }
    
}
