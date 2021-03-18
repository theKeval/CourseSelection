//
//  AllCoursesTableViewCell.swift
//  CourseSelection
//
//  Created by Keval on 3/17/21.
//

import UIKit

// Thic class will be associated with TableViewCell of AllCourses TableView
class AllCoursesTableViewCell: UITableViewCell {
    
    // Outlets connection with UI
    @IBOutlet weak var uiCourseImage: UIImageView!
    @IBOutlet weak var uiCourseName: UILabel!
    @IBOutlet weak var uiHours: UILabel!
    @IBOutlet weak var uiPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // function to set the TableViewCell
    func setCourseData(course: CourseModel) {
        uiCourseImage.image = UIImage(named: course.courseImage)
        uiCourseName.text = course.courseName
        uiHours.text = "\(String(course.hours)) Hours"
        uiPrice.text = "$ \(String(course.fee))"
    }

}
