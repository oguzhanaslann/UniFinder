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

    
    private var clickListener : onDidTapItemListener? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if(selected){
            clickListener?.didtapItem()
        }
    }
    
    
    
    func setItemClickListener(onclickListener : onDidTapItemListener) {
        self.clickListener = onclickListener
    }
    
    
}

protocol onDidTapItemListener  : AnyObject{
    func didtapItem()
}
