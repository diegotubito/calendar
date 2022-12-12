//
//  CarrouselCollectionView.swift
//  Calendar
//
//  Created by David Gomez on 21/11/2022.
//

import UIKit

extension CarrouselView {
    class Body: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        lazy var collectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 0
            let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collection.isScrollEnabled = true
            collection.isPagingEnabled = true
            collection.delegate = self
            collection.dataSource = self
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.register(CarrouselCell.self, forCellWithReuseIdentifier: CarrouselCell.identifier)
            collection.backgroundColor = .gray
            return collection
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
            addSubview(collectionView)
        }
        
        private func setupConstrainsts() {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
            ])
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.frame.width / 2.5, height: self.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarrouselCell.identifier, for: indexPath) as! CarrouselCell
            cell.title = "\(indexPath.row)"
            return cell
        }
    }
}
