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
    var height: CGFloat
    var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
        }
    }
    
    weak var delegate: CalendarDayViewDelegate?
    
    public lazy var roundedView: RoundedView = {
        let imageView = RoundedView()
        self.addSubview(imageView)
        imageView.layer.cornerRadius = height/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: height),
            imageView.heightAnchor.constraint(equalToConstant: height),
        ])
        
        return imageView
    }()
    
    init(height: CGFloat) {
        self.height = height
        super .init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .yellow
        roundedView.viewDidTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.didSelectDayView(date: self.date)
        }
    }
    
}


class RoundedView: UIView {
    
    var viewDidTapped: (() -> Void )?
    
    public lazy var titleLabel: UILabel = {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewTapped() {
       viewDidTapped?()
    }
}
