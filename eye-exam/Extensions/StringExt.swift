//
//  StringExt.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
//    subscript (i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//    subscript (bounds: CountableRange<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return self[start ..< end]
//    }
//    subscript (bounds: CountableClosedRange<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return self[start ... end]
//    }
//    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(endIndex, offsetBy: -1)
//        return self[start ... end]
//    }
//    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return self[startIndex ... end]
//    }
//    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return self[startIndex ..< end]
//    }
    
}
