//
//  CarrouselHeaderView.swift
//  Calendar
//
//  Created by David Gomez on 21/11/2022.
//
import UIKit

extension CarrouselView {
    class Header: UIView {
        var title: String = "" {
            didSet {
                titleLabel.text = title
            }
        }
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
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
            addViews()
            setupConstrainsts()
        }
        
        private func addViews() {
            addSubview(titleLabel)
        }
        
        private func setupConstrainsts() {
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
            ])
        }
        
    }
}
