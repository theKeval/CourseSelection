//
//  CourseModel.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import Foundation

// Model class for Course
class CourseModel {
    var courseName: String
    var courseImage: String
    var hours: Int
    var fee: Double
    
    init(_name: String, _img: String, _hours: Int, _fee: Double) {
        self.courseName = _name
        self.courseImage = _img
        self.hours = _hours
        self.fee = _fee
    }
    
}

// top-level variable to hold MyData shared object
private let _myData = MyData()

// class to hold the data throughout the application
class MyData {
    
    // variable for shared instance of data class
    class var sharedInstance: MyData {
        return _myData
    }
    
    // variables to hold the data that we'll be using throughout the application
    var allCourses = [CourseModel]()
    var selectedCourses = [CourseModel]()
    var totalHours = 0
    
    // function to fill the All courses array
    func fillAllCourses() {
        let courseList = [
            CourseModel(_name: "Java", _img: "java", _hours: 5, _fee: 1600),
            CourseModel(_name: "Python", _img: "python", _hours: 4, _fee: 1850),
            CourseModel(_name: "Database", _img: "database", _hours: 3, _fee: 1300),
            CourseModel(_name: "Web Development", _img: "webDev", _hours: 4, _fee: 1200),
            CourseModel(_name: "iOS Development", _img: "iOSdev", _hours: 5, _fee: 2200),
            CourseModel(_name: "Android Development", _img: "android", _hours: 5, _fee: 2000),
            CourseModel(_name: "System Analysis", _img: "sysAnalysis", _hours: 4, _fee: 1900),
            CourseModel(_name: "Cloud Computing", _img: "cloudComputing", _hours: 3, _fee: 1250),
            CourseModel(_name: "Machine Learning", _img: "machineLearning", _hours: 5, _fee: 2300),
            CourseModel(_name: "Problem Solving", _img: "problemSolving", _hours: 3, _fee: 950)
        ]
        
        allCourses.append(contentsOf: courseList)
    }
    
}

// protocol to use the delete function from inside the TableViewCell
protocol CellFunctionality {
    func delete(course: CourseModel?)
}
