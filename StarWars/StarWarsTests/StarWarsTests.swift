//
//  StarWarsTests.swift
//  StarWarsTests
//
//  Created by Mariano Manuel on 5/25/21.
//

import XCTest
@testable import StarWars

class StarWarsTests: XCTestCase {
    var session: URLSession!
    let starWarsURL = URL(string: "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }

    func testValidHTTPStatusCode200() {
        let promise = expectation(description: "Status Code: 200")
        let dataTask = session.dataTask(with: starWarsURL!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testAPICallCompletes() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = session.dataTask(with: starWarsURL!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

}
