//
//  ThisIsBudUITests.swift
//  ThisIsBudUITests
//
//  Created by Motionmetrics on 28/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import XCTest

class ThisIsBudUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSimpleFlow() throws {
        let app = XCUIApplication()
        app.launch()

        let transactionsNavigationBar = app.navigationBars["Transactions"]
        transactionsNavigationBar.buttons["Edit"].tap()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Forbidden planet"]/*[[".cells.staticTexts[\"Forbidden planet\"]",".staticTexts[\"Forbidden planet\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yamaha music london"]/*[[".cells.staticTexts[\"Yamaha music london\"]",".staticTexts[\"Yamaha music london\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Blizzard entertainment"]/*[[".cells.staticTexts[\"Blizzard entertainment\"]",".staticTexts[\"Blizzard entertainment\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Remove"]/*[[".buttons[\"Remove\"].staticTexts[\"Remove\"]",".staticTexts[\"Remove\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        transactionsNavigationBar.buttons["Done"].tap()

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
