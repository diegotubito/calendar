//
//  CarrouselView.swift
//  Calendar
//
//  Created by David Gomez on 21/11/2022.
//

import UIKit

class CarrouselView: UIView {
    lazy var headerView: CarrouselView.Header = {
       let view = CarrouselView.Header()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.title = "My Performances"
        return view
    }()
    
    lazy var bodyView: CarrouselView.Body = {
        let view = CarrouselView.Body()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .gray
        addViews()
        setupConstrainsts()
        setupBindings()
    }
    
    private func addViews() {
        addSubview(headerView)
        addSubview(bodyView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            headerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            headerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            
            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            bodyView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            bodyView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            bodyView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupBindings() {
        
    }
}
