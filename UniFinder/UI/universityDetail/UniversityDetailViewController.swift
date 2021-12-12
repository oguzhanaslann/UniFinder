//
//  UniversityDetailViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 8.10.2021.
//

import UIKit
import Kingfisher

class UniversityDetailViewController: UIViewController {
    
    static let emptyUniId : Int  =  -1 
    
    var universityId : Int  = emptyUniId
    
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var universityCityName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel : UniversityDetailViewModel = {
        return Injector.shared.injectUniversityDetailViewModel()
    }()
    
    private let progressIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        universityImage.contentMode = .scaleAspectFit
        
        
        collectionView.register(PromotionCollectionViewCell.getNib(), forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        setUpObservers()
        

        
    }
    
    func  setUpObservers() {
        viewModel.universityDetail.observe(on: self) { detailState in
            print("\(detailState) state ")
            switch detailState {
                case .Error(let error):
                    print("error \(error)")
                    break
                case .Loading:
                    print("load ")
                    self.universityName.isHidden  = true
                    self.universityCityName.isHidden  = true
                    self.universityImage.isHidden  = true
                    self.progressIndicator.isHidden = true
                    self.collectionView.isHidden  = true
                    self.progressIndicator.startAnimating()
                    break
                case .Success(let detail ):
                    print("loaded success ")
                    self.universityName.isHidden  = false
                    self.universityCityName.isHidden  = false
                    self.universityImage.isHidden  = false
                    self.collectionView.isHidden  = false
                    self.progressIndicator.stopAnimating()
                    
                    self.universityImage?.kf.setImage(with: URL(string: detail.data.coverPhotoUrl))
                    self.universityName.text = detail.data.name
                    self.universityCityName.text = detail.data.cityName
                    self.universityImage.layer.addSublayer(createGradientLayer(with: self.universityImage.bounds))
                    self.collectionView.reloadData()
                   break
            case .Empty:
                if self.universityId != UniversityDetailViewController.emptyUniId {
                    self.viewModel.getUniversityDetailFor(id: self.universityId)
                }
                break
            }
            
       
            
            
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
        switch viewModel.universityDetail.value {
        case .Success(let value):
            return value.data.promotionImageUrls.count
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.identifier, for: indexPath) as? PromotionCollectionViewCell
        
        guard cell != nil else {
            return UICollectionViewCell()
        }
        
        
        switch viewModel.universityDetail.value {
            case .Success(let value):
                if value.data.promotionImageUrls.count > 0 {
                    cell?.initWith(promotionImageUrl:value.data.promotionImageUrls[indexPath.row] )
                }
              
            default:
               break
        }
        
        
        return cell!
    }
    
    
}


extension UniversityDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
           // in case you you want the cell to be 60% of your controllers view
        return CGSize(width: width * 0.6, height: 72)
    }
}
