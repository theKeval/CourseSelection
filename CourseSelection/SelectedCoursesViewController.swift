//
//  SelectedCoursesViewController.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

class SelectedCoursesViewController: UIViewController {
    
    @IBOutlet weak var uiTotalHours: UILabel!
    @IBOutlet weak var uiTotalFees: UILabel!
    @IBOutlet weak var uiNoCourses: UILabel!
    @IBOutlet weak var tvSelectedCourses: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    var totalFees = Double(0)
    var selected: CourseModel?
    
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
    
    @IBAction func removeSelected(_ sender: UIButton) {
        
        if let course = selected {
            
            MyData.sharedInstance.selectedCourses.removeAll { (_course) -> Bool in
                _course.courseName == course.courseName
            }
            
            tvSelectedCourses.reloadData()
            MyData.sharedInstance.totalHours -= course.hours
            totalFees -= course.fee
            
            uiTotalHours.text = "\(String(MyData.sharedInstance.totalHours)) Hours"
            uiTotalFees.text = "$ \(String(format: "%.2f", totalFees))"
            
            selected = nil
            setVisibility()
        }
        else {
            // no selection has been made to delete
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- helper functions
    
    func setVisibility() {
        if MyData.sharedInstance.selectedCourses.count == 0 {
            uiNoCourses.isHidden = false
            tvSelectedCourses.isHidden = true
            btnRemove.isHidden = true
        }
        else {
            uiNoCourses.isHidden = true
            tvSelectedCourses.isHidden = false
            btnRemove.isHidden = false
        }
    }
    
}

extension SelectedCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyData.sharedInstance.selectedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCourse = MyData.sharedInstance.selectedCourses[indexPath.row]
        
        let cell = tvSelectedCourses.dequeueReusableCell(withIdentifier: "tvcell_selectedCourses") as! SelectedCoursesTableViewCell
        cell.setCourseData(course: selectedCourse)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = MyData.sharedInstance.selectedCourses[indexPath.row]
    }
    
}
