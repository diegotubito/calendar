//
//  PlayButtonView.swift
//  Calendar
//
//  Created by David Gomez on 21/11/2022.
//

import UIKit

extension CarrouselView {
    class Play: UIView {
        var didPlayButtonTapped: (() -> Void)?
        
        lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = UIImage(named: "play.icon")
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            view.addGestureRecognizer(tap)
            return view
        }()
        
        @objc func tapHandler() {
            didPlayButtonTapped?()
        }
        
        override init(frame: CGRect) {
            super .init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            backgroundColor = .black.withAlphaComponent(0.7)
            addViews()
            setupConstrainsts()
        }
        
        private func addViews() {
            addSubview(imageView)
        }
        
        private func setupConstrainsts() {
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 50),
                imageView.widthAnchor.constraint(equalToConstant: 50),
                imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
                imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
            ])
        }
    }
}
