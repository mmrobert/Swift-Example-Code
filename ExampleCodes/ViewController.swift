//
//  ViewController.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendarView: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.calendarView.layer.borderWidth = 2.0
        self.calendarView.layer.borderColor = UIColor.lightGray.cgColor
        self.calendarView.layer.masksToBounds = true
        
        self.calendarView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: CalendarViewDataSource {
    
    func startDate() -> Date? {
        
        let today = Date()
        let eightMonthsAgo = self.calendarView.calendar.date(byAdding: .month, value: -8, to: today)
        
        return eightMonthsAgo
    }
    
    func endDate() -> Date? {
        
        let today = Date()
        let fiveYearsFromNow = self.calendarView.calendar.date(byAdding: .year, value: 5, to: today)
        
        return fiveYearsFromNow
    }
}

