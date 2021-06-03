//
//  StarWarsUITests.swift
//  StarWarsUITests
//
//  Created by Mariano Manuel on 5/25/21.
//

import XCTest

class StarWarsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadingService() {
        //Wait & Browse Items after Load
        sleep(10)
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        let cards = app.collectionViews.cells
        XCTAssert(cards.element.exists)
        XCTAssert(cards.element(boundBy: 0).isHittable)
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(3)
        XCTAssert(cards.element.exists)
        XCTAssert(cards.element(boundBy: 0).isHittable)
        XCUIDevice.shared.orientation = .landscapeRight
    }
    
    func testMasterDetailViews() {
        //Test Longest Text Card. Scroll Back&Forth and Return to MasterView
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        let cards = app.collectionViews.cells
        cards.element(boundBy: 2).tap()
        sleep(3)
        let title = app.staticTexts["Funeral of Qui-Gon Jinn"]
        let location = app.staticTexts["Theed, Naboo"]
        XCTAssert(title.exists)
        XCTAssert(location.exists)
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        sleep(2)
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        let BackButton = app.buttons["Star Wars"]
        XCTAssert(BackButton.exists)
        XCTAssert(BackButton.isHittable)
        BackButton.tap()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
    }
    
    func testSaveCapture() {
        //Select Item and Save Capture from DetailView
        let cards = app.collectionViews.cells
        cards.element(boundBy: 2).tap()
        let title = app.staticTexts["Run the Naboo Blockade"]
        let location = app.staticTexts["Naboo"]
        XCTAssert(title.exists)
        XCTAssert(location.exists)
        let shareButton = app.navigationBars.buttons["share"]
        XCTAssert(shareButton.exists)
        XCTAssert(shareButton.isHittable)
        shareButton.tap()
        sleep(4)
        let saveImage = app.buttons["Save Image"]
        XCTAssert(saveImage.exists)
        XCTAssert(saveImage.isHittable)
        saveImage.tap()
    }
}
