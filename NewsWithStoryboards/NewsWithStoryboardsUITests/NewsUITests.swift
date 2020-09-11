//
//  NewsWithStoryboardsUITests.swift
//  NewsWithStoryboardsUITests
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest

class NewsWithStoryboardsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_tableview_Cell_and_Back() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let myTable = app.tables.matching(identifier: "article_TV_AI")
        let cell = myTable.cells.element(matching: .cell, identifier: "articleCell_0")
        print(app.debugDescription)
        cell.tap()
        XCUIApplication().navigationBars["Detail"].buttons["Articles"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
