//
//  PromotionCollectionViewCell.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 16.10.2021.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    
    static let identifier : String = "PromotionCollectionViewCell"
    
    @IBOutlet weak var promotionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        promotionImage?.layer.masksToBounds = true
        promotionImage?.layer.cornerRadius = 16
        promotionImage?.clipsToBounds = true
    }
    
    

    func initWith(promotionImageUrl : String ){
        promotionImage.kf.setImage(with: URL(string: promotionImageUrl))
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: PromotionCollectionViewCell.identifier, bundle: nil )
    }
    
    

}

