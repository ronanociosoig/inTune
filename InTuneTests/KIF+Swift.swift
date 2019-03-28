//
//  KIF+Swift.swift
//  KIFDemoApp
//
//  Created by Andy Obusek on 4/27/16.
//  Copyright © 2016 Clean Swifter. All rights reserved.
//

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