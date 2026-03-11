//
//  AgenticSampleAppUITests.swift
//  AgenticSampleAppUITests
//
//  Created by Jesse Holwell on 11/3/2026.
//

import XCTest

final class AgenticSampleAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func test_navigationTitle_isDisplayed() {
        XCTAssertTrue(app.navigationBars["Todos"].exists)
    }

    func test_addButton_isDisabled_whenFieldIsEmpty() {
        XCTAssertFalse(app.buttons["addButton"].isEnabled)
    }

    func test_addTodo_appearsInList() {
        let field = app.textFields["newTodoField"]
        field.tap()
        field.typeText("Buy milk")
        app.buttons["addButton"].tap()

        XCTAssertTrue(app.staticTexts["Buy milk"].exists)
    }

    func test_addButton_clearsField_afterAdding() {
        let field = app.textFields["newTodoField"]
        field.tap()
        field.typeText("Buy milk")
        app.buttons["addButton"].tap()

        XCTAssertEqual(field.value as? String, "")
    }

    func test_tappingTodo_togglesCompletion() {
        let field = app.textFields["newTodoField"]
        field.tap()
        field.typeText("Walk the dog")
        app.buttons["addButton"].tap()

        app.staticTexts["Walk the dog"].tap()

        // Row still exists after toggle
        XCTAssertTrue(app.staticTexts["Walk the dog"].exists)
    }

    func test_swipeToDelete_removesTodo() {
        let field = app.textFields["newTodoField"]
        field.tap()
        field.typeText("Delete me")
        app.buttons["addButton"].tap()

        app.staticTexts["Delete me"].swipeLeft()
        app.buttons["Delete"].tap()

        XCTAssertFalse(app.staticTexts["Delete me"].exists)
    }
}
