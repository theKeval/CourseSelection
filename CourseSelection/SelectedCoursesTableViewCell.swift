//
//  SelectedCoursesTableViewCell.swift
//  CourseSelection
//
//  Created by Keval on 3/18/21.
//

import UIKit

class SelectedCoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var uiCourseImage: UIImageView!
    @IBOutlet weak var uiCourseName: UILabel!
    @IBOutlet weak var uiHourAndPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCourseData(course: CourseModel) {
        self.uiCourseImage.image = UIImage(named: course.courseImage)
        self.uiCourseName.text = course.courseName
        self.uiHourAndPrice.text = "\(course.hours) Hours, $ \(course.fee)"
    }

    @IBAction func deleteCourse(_ sender: UIButton) {
        
        MyData.sharedInstance.selectedCourses.removeAll { (_course) -> Bool in
            _course.courseName == uiCourseName.text
        }
        
        
        
        if let tvView = self.superview as! UITableView? {
            tvView.reloadData()
        }
        
    }
    
}
