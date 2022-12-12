//
//  ViewController.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        addCarrousel()
       
    }
    func addCarrousel() {
        let secondCarrousel = CarrouselView()
        secondCarrousel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(secondCarrousel)
        NSLayoutConstraint.activate([
            secondCarrousel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            secondCarrousel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 2),
            secondCarrousel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        ])
    }
    
   
 }
