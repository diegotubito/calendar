//
//  CarrouselCell.swift
//  Calendar
//
//  Created by David Gomez on 21/11/2022.
//

import UIKit

class CarrouselCell: UICollectionViewCell {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // remove titleLAbel at the end
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playView: CarrouselView.Play = {
        let view = CarrouselView.Play()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .green
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    private func commonInit() {
        addViews()
        setupConstrainsts()
        setupBinding()
    }
    
    private func setupBinding() {
        playView.didPlayButtonTapped = {
            print("must play video here")
        }
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(playView)
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            playView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            playView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            playView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            playView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
        ])
    }
}

