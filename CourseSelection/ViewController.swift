//
//  ViewController.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tvAllCourses: UITableView!
    
    var selectedCourse: CourseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up the View
        if MyData.allCourses.count == 0 {
            MyData.fillAllCourses()
        }
        
        tvAllCourses.delegate = self
        tvAllCourses.dataSource = self
        tvAllCourses.tableFooterView = UIView()
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyData.allCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = MyData.allCourses[indexPath.row]
        
        let cell = tvAllCourses.dequeueReusableCell(withIdentifier: "tvcell_allCourses") as! AllCoursesTableViewCell
        cell.setCourseData(course: course)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCourse = MyData.allCourses[indexPath.row]
    }
    
}

