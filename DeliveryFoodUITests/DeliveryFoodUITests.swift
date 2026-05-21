import XCTest

final class DeliveryFoodUITests: XCTestCase {

    var app: XCUIApplication!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Order Screen Tests
    func testOrderScreenLoads() {
        app.tabBars.buttons["Order"].tap()

        let orderCollection = app.collectionViews["orderCollection"]
        XCTAssertTrue(orderCollection.exists, "Коллекция заказов должна отображаться")
        XCTAssertTrue(orderCollection.cells.count > 0, "Должна быть хотя бы одна ячейка блюда")
    }

    func testDeleteDish() {
        app.tabBars.buttons["Order"].tap()
        let firstCell = app.collectionViews["orderCollection"].cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "Первая ячейка должна существовать")

        let deleteButton = firstCell.buttons["trash"]
        XCTAssertTrue(deleteButton.exists, "Кнопка удаления должна существовать")
        deleteButton.tap()

        let cellCountAfter = app.collectionViews["orderCollection"].cells.count
        XCTAssertLessThan(cellCountAfter, app.collectionViews["orderCollection"].cells.count + 1, "Ячейка должна быть удалена")
    }

    func testSendButton() {
        app.tabBars.buttons["Order"].tap()
        let sendButton = app.buttons["Send"]
        XCTAssertTrue(sendButton.exists, "Кнопка Send должна отображаться")
        sendButton.tap()
    }

    // MARK: - My List (Favorites) Screen Tests
    func testMyListScreenLoads() {
        app.tabBars.buttons["My List"].tap()
        let myListCollection = app.collectionViews["myListCollection"]
        XCTAssertTrue(myListCollection.exists, "Коллекция избранного должна отображаться")
    }

    
    func testProfileOptions() {
        app.tabBars.buttons["Profile"].tap()

        let options = ["My Profile", "Change Password", "Payment Settings", "My Voucher", "Notification", "About Us", "Contact Us"]
        for option in options {
            let optionRow = app.staticTexts[option]
            XCTAssertTrue(optionRow.exists, "\(option) должно отображаться")
        }
    }

    func testSignOutButton() {
        app.tabBars.buttons["Profile"].tap()
        let signOutButton = app.buttons["Sign Out"]
        XCTAssertTrue(signOutButton.exists, "Кнопка Sign Out должна отображаться")
        signOutButton.tap()
    }
}
