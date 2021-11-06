//
//  TableViewCell.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 23.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - IBOUTLETS
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var universityCityName: UILabel!
    
    
    public static let  indentifier = "TableViewCell"
    
    private var position : Int? = nil
    private var clickListener : onDidTapItemListener? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        universityImage?.layer.masksToBounds = true
        universityImage?.layer.cornerRadius = 16
        universityImage?.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if(selected){
            clickListener?.didtapItem(position: position)
        }
    }
    
    
    
    func setItemClickListener(onclickListener : onDidTapItemListener) {
        self.clickListener = onclickListener
    }
    
    func setItemPosition(position:Int){
        self.position = position
    }
    
    func initWith(universityName:String,universityCityName:String,imageUrl : URL,position:Int){
        self.universityName.text = universityName
        self.universityCityName.text = universityCityName
        universityImage?.kf.setImage(with: imageUrl)
        setItemPosition(position: position)
    }
    
}

protocol onDidTapItemListener  : AnyObject{
    func didtapItem(position:Int?)
}
