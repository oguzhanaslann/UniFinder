//
//  UniversityDetailViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 8.10.2021.
//

import UIKit
import Kingfisher

class UniversityDetailViewController: UIViewController {
    
    static let emptyUniId : String = ""
    
    var universityId : String = emptyUniId
    
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var universityCityName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = UniversityDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        universityImage.contentMode = .scaleAspectFit
        
        
        collectionView.register(PromotionCollectionViewCell.getNib(), forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        setUpObservers()
        
        if universityId != UniversityDetailViewController.emptyUniId {
            viewModel.getUniversityDetailFor(id: universityId)
        }
        
    }
    
    func  setUpObservers() {
        viewModel.universityDetail.observe(on: self) { detail in
            
            guard detail != nil else {
                return
            }
            
            self.universityImage?.kf.setImage(with: URL(string: detail!.coverPhotoUrl))
            self.universityName.text = detail?.name
            self.universityCityName.text = detail?.cityName
            self.universityImage.layer.addSublayer(createGradientLayer(with: self.universityImage.bounds))
            self.collectionView.reloadData()
        }
    }
    

}


extension UniversityDetailViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension UniversityDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.universityDetail.value?.promotionImageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.identifier, for: indexPath) as? PromotionCollectionViewCell
        
        guard cell != nil else {
            return UICollectionViewCell()
        }
        
        if viewModel.universityDetail.value != nil
            && indexPath.row < viewModel.universityDetail.value!.promotionImageUrls.count
            && viewModel.universityDetail.value!.promotionImageUrls.count > 0 {
            
            cell?.initWith(promotionImageUrl:viewModel.universityDetail.value!.promotionImageUrls[indexPath.row] )
        
        }
        
        return cell!
    }
    
    
}


extension UniversityDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
           // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.6, height: 72)
    }
}
