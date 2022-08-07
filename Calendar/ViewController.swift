//
//  ViewController.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendar: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendar.setInitialValue(currentDate: Date())
        calendar.dateDidSelect = { [weak self] date in
            guard let self = self else { return }
            
            print(date)
            
        }
    }

}

