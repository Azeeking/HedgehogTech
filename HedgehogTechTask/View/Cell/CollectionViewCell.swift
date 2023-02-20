//
//  CollectionViewCell.swift
//  HedgehogTechTask
//
//  Created by Azik on 16.02.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(image:UIImage?){
        imageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
