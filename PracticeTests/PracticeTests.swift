//
//  PracticeTests.swift
//  PracticeTests
//
//  Created by Paul Ancajima on 11/15/23.
//

import XCTest
import Foundation
@testable import Practice

final class PracticeTests: XCTestCase {
    
    override func setUp() async throws {}
    
    func testSanity() {
        XCTAssert(1==1)
    }
    
}


enum CustomError: Error {
    case customError1
    case customError2
}

extension CustomError {
    var localizedError: String {
        switch self {
        case .customError1:
            return "custom Error1"
        case .customError2:
            return "custom Error2"
        }
    }
}
