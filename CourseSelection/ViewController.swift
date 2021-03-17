//
//  ViewController.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tvAllCourses: UITableView!
    @IBOutlet weak var btnAddToProgram: UIButton!
    @IBOutlet weak var btnViewSelectedCourses: UIButton!
    
    var selectedCourse: CourseModel?
    var totalFees = Double(0)
    
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

    @IBAction func addCourseToProgram(_ sender: UIButton) {
        
        if let course = selectedCourse {
            let condition = shouldAddCourse(_course: course)
            
            if condition.check {
                // add the course
                MyData.selectedCourses.append(course)
                MyData.totalHours += course.hours
                totalFees += course.fee
                
                showAlertToast(message: "Course added to your program!", seconds: 2.5)
            }
            else {
                switch condition.reason {
                
                    case ErrorType.ALREADY_EXIST:
                        showAlertToast(message: "You have already selected this course previously!", seconds: 4)
                        
                    case ErrorType.HOURS_EXCEED:
                        showAlertToast(message: "Total hours of all selected courses, exceed the limit of 19 hours!", seconds: 4)
                
                }
            }
            
        }
        
    }
    
    @IBAction func viewSelectedCourses(_ sender: Any) {
        performSegue(withIdentifier: "segue_viewSelectedCourses", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectedCoursesViewController
        vc.totalFees = self.totalFees
    }
    
    // MARK:- Helper methods
    
    enum ErrorType {
        case ALREADY_EXIST
        case HOURS_EXCEED
    }
    
    func shouldAddCourse(_course: CourseModel) -> (check: Bool, reason: ErrorType) {
        var check = false
        var reason = ErrorType.ALREADY_EXIST
        
        let contains = MyData.selectedCourses.contains { (_courseModel) -> Bool in
            _courseModel.courseName == _course.courseName
        }
        
        if contains {
            check = false
            reason = ErrorType.ALREADY_EXIST
        }
        else {
            if (MyData.totalHours + _course.hours) < 19 {
                check = true
            }
            else {
                check = false
                reason = ErrorType.HOURS_EXCEED
            }
        }
        
        return (check, reason)
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

