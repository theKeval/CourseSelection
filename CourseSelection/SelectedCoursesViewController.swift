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
    @IBOutlet weak var tvSelectedCourses: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up the initial UI
        tvSelectedCourses.delegate = self
        tvSelectedCourses.dataSource = self
        tvSelectedCourses.tableFooterView = UIView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension SelectedCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyData.selectedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCourse = MyData.selectedCourses[indexPath.row]
        
        let cell = tvSelectedCourses.dequeueReusableCell(withIdentifier: "tvcell_selectedCourses") as! SelectedCoursesTableViewCell
        cell.setCourseData(course: selectedCourse)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // code to execute on row selection
    }
    
}
