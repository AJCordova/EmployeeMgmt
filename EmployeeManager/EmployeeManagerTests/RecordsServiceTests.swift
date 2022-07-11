//
//  RecordsServiceTests.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/11/22.
//

import XCTest
@testable import EmployeeManager

class RecordsServiceTests: XCTestCase {
    var service: RecordsServiceProtocol?
    
    override func setUpWithError() throws {
        service = RecordsServiceMock()
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    func testadd() throws {
        // arrange
        let newEmployee = Employee(name: "Archer Sterling", isEmployed: true, department: "Field")
        
        // act
        service?.add(employee:  newEmployee)
        
        // assert
        XCTAssert(SampleEmployer.data.employees?.count == 5)
        XCTAssert(SampleEmployer.data.employees?.contains(newEmployee) == true)
    }
    
    func testEdit() throws {
        // arrange
        var employee = SampleEmployer.data.employees?.first
        employee?.department = "Sleeper Cell"
        
        // act
        guard let employee = employee else { return }
        service?.edit(employee: employee)
        
        // assert
        XCTAssert(SampleEmployer.data.employees?.first?.department == employee.department)
    }
    
    func testDelete() throws {
        // arrange
        let employee = SampleEmployer.data.employees?.first
        
        // act
        guard let employee = employee else { return }
        service?.delete(employee: employee)
        
        // assert
        XCTAssert(SampleEmployer.data.employees?.contains(employee) == false)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
