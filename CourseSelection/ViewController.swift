//
//  ViewController.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets connection to UI
    @IBOutlet weak var tvAllCourses: UITableView!
    @IBOutlet weak var btnAddToProgram: UIButton!
    @IBOutlet weak var btnViewSelectedCourses: UIButton!
    
    var selectedCourse: CourseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if all course list is empty -> fill all data
        if MyData.sharedInstance.allCourses.count == 0 {
            MyData.sharedInstance.fillAllCourses()
        }
        
        // set-up tableView
        tvAllCourses.delegate = self
        tvAllCourses.dataSource = self
        tvAllCourses.tableFooterView = UIView()
        
    }

    // action function for addToCourse Button
    @IBAction func addCourseToProgram(_ sender: UIButton) {
        
        // check if user selected any course or not
        if let course = selectedCourse {
            // check for should we add the course or not
            // if not, then get the result
            let condition = shouldAddCourse(_course: course)
            
            if condition.check {
                // add the course
                MyData.sharedInstance.selectedCourses.append(course)
                MyData.sharedInstance.totalHours += course.hours
                
                // showing simple toast for course added message
                showCustomToast(message: "Course added!", font: .systemFont(ofSize: CGFloat(17)))
            }
            else {  // if we shouldn't add the course
                // switch through the reason
                switch condition.reason {
                
                    case ErrorType.ALREADY_EXIST:
                        showAlertToast(message: "You have already selected this course previously!", seconds: 4)
                        
                    case ErrorType.HOURS_EXCEED:
                        showAlertToast(message: "Total hours of all selected courses, exceed the limit of 19 hours!", seconds: 4)
                
                }
            }
            
        }
        
    }
    
    // action function for perform segue on view selected course button
    @IBAction func viewSelectedCourses(_ sender: Any) {
        // navigate to selectedCourseList ViewController
        performSegue(withIdentifier: "segue_viewSelectedCourses", sender: self)
    }
    
    // prepare before perofming the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get the ViewController
        let vc = segue.destination as! SelectedCoursesViewController
        
        // calculate the total fees
        var totalFees = Double(0)
        for item in MyData.sharedInstance.selectedCourses {
            totalFees += item.fee
        }
        
        // pass the totalFees data to new ViewController
        vc.totalFees = totalFees
    }
    
    
    // MARK:- Helper methods
    
    // defining types of error for unable to add course to program
    enum ErrorType {
        case ALREADY_EXIST
        case HOURS_EXCEED
    }
    
    // checks two condition before adding the course
    func shouldAddCourse(_course: CourseModel) -> (check: Bool, reason: ErrorType) {
        var check = false
        var reason = ErrorType.ALREADY_EXIST
        
        // first check is the course previously added to list
        let contains = MyData.sharedInstance.selectedCourses.contains { (_courseModel) -> Bool in
            _courseModel.courseName == _course.courseName
        }
        
        if contains {
            check = false
            reason = ErrorType.ALREADY_EXIST
        }
        else {  // if course not added previously
            // check the total hours
            if (MyData.sharedInstance.totalHours + _course.hours) < 19 {
                check = true
            }
            else {
                check = false
                reason = ErrorType.HOURS_EXCEED
            }
        }
        
        // return the check and reason
        return (check, reason)
    }
    
}

//MARK:- creating extension to our ViewController

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyData.sharedInstance.allCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = MyData.sharedInstance.allCourses[indexPath.row]
        
        let cell = tvAllCourses.dequeueReusableCell(withIdentifier: "tvcell_allCourses") as! AllCoursesTableViewCell
        cell.setCourseData(course: course)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCourse = MyData.sharedInstance.allCourses[indexPath.row]
    }
    
}


// MARK:- creating extension to UIViewController for Toast message functions

extension UIViewController{

    func showAlertToast(message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .darkGray
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func showCustomToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
        // Usage of this function:-
        // showCustomToast(message: "Course added to Program", font: .systemFont(ofSize: 17))
    }
    
 }

