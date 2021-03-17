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
            // add course to selected course list
            let contains = MyData.selectedCourses.contains { (_course) -> Bool in
                _course.courseName == course.courseName
            }
            
            if contains{
                showAlertToast(message: "You have already selected this course previously!", seconds: 4)
                // showCustomToast(message: "You have already selected this course previously.", font: .systemFont(ofSize: 17))
            }
            else {
                MyData.selectedCourses.append(course)
                showAlertToast(message: "Course added to program!", seconds: 3)
                // showCustomToast(message: "Course added to Program", font: .systemFont(ofSize: 17))
            }
            
        }
        
    }
    
    @IBAction func viewSelectedCourses(_ sender: Any) {
        
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

    func showAlertToast(message : String, seconds: Double){
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
    }
    
    
 }

