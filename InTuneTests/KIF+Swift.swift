//
//  KIF+Swift.swift
//  InTuneTests
//
//  Created by Ronan on 31/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}
