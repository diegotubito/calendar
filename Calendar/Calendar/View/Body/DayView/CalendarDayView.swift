//
//  CalendarDayView.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit
protocol CalendarDayViewDelegate: AnyObject {
    func didSelectDayView(date: Date?)
}

class CalendarDayView: UIView {
    var date: Date?
    var index: Int?
    var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
        }
    }
    
    weak var delegate: CalendarDayViewDelegate?
    
    public lazy var roundedBackground: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        roundedBackground.layer.cornerRadius = 30/2
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let contentFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        frame = contentFrame
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        
        backgroundColor = .yellow
    }
    
    @objc private func viewTapped() {
        delegate?.didSelectDayView(date: date)
    }
}
