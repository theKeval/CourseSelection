//
//  SelectedCoursesViewController.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

class SelectedCoursesViewController: UIViewController {
    
    // Outlets to connect to UI
    @IBOutlet weak var uiTotalHours: UILabel!
    @IBOutlet weak var uiTotalFees: UILabel!
    @IBOutlet weak var uiNoCourses: UILabel!
    @IBOutlet weak var tvSelectedCourses: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    // Variable declarations
    var totalFees = Double(0)
    var selected: CourseModel?
    
    // function to setup UI after UI components will be loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up the initial UI
        
        setVisibility()
        
        uiTotalHours.text = "\(String(MyData.sharedInstance.totalHours)) Hours"
        uiTotalFees.text = "$ \(String(totalFees))"
        
        tvSelectedCourses.delegate = self
        tvSelectedCourses.dataSource = self
        tvSelectedCourses.tableFooterView = UIView()
        
    }
    
    // action function for back button click
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- helper functions
    
    // function to set visibility of TableView if no course have been selected
    func setVisibility() {
        // check if user have no course selected
        if MyData.sharedInstance.selectedCourses.count == 0 {
            uiNoCourses.isHidden = false
            tvSelectedCourses.isHidden = true
        }
        else {
            uiNoCourses.isHidden = true
            tvSelectedCourses.isHidden = false
        }
    }
    
}

// extension to ViewController to get the functionality of TableView
extension SelectedCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // function to identify number of rows in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyData.sharedInstance.selectedCourses.count
    }
    
    // function to define reusable TableViewCell to use in the TableView and setup the cell properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCourse = MyData.sharedInstance.selectedCourses[indexPath.row]
        
        let cell = tvSelectedCourses.dequeueReusableCell(withIdentifier: "tvcell_selectedCourses") as! SelectedCoursesTableViewCell
        cell.setCourseData(course: selectedCourse, cellFunc: self)
        
        return cell
    }
    
    // function to set the selected row in tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = MyData.sharedInstance.selectedCourses[indexPath.row]
    }
    
}

// extension to define the delete function which will be used when the user clicks on the delete button in any individual row of TableView
extension SelectedCoursesViewController: CellFunctionality {
    
    func delete(course: CourseModel?) {
        // code to delete
        if let cellCourse = course{
            
            // remove the selected item from the array of selectedCourses
            MyData.sharedInstance.selectedCourses.removeAll { (_course) -> Bool in
                _course.courseName == cellCourse.courseName
            }
            
            // reload the tableView to reflect the change
            tvSelectedCourses.reloadData()
            
            // reset the values of totalHours and totalFees
            MyData.sharedInstance.totalHours -= cellCourse.hours
            totalFees -= cellCourse.fee
            
            // reset the lables for totalHours and totalFees
            uiTotalHours.text = "\(String(MyData.sharedInstance.totalHours)) Hours"
            uiTotalFees.text = "$ \(String(format: "%.2f", totalFees))"
            
            // reset the visibility for tableView and no data error lable
            setVisibility()
            
        }
        
    }
}
