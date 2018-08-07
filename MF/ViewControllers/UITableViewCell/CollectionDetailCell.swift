//
//  CollectionDetailCell.swift
//  MF
//
//  Created by Ahmed Durrani on 07/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

protocol AmazaonLinkClick {
    func isLinkClickedOrNot(checkCell : CollectionDetailCell , indexPath : IndexPath)
    
    
}
class CollectionDetailCell: UITableViewCell {
    var delegate: AmazaonLinkClick?
    var index: IndexPath?
    @IBOutlet var imageOfCollections: UIImageView!
    @IBOutlet var lblPrice: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnIsFavOrUnFav(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        self.delegate?.isLinkClickedOrNot(checkCell : self  , indexPath : index!)
        
        
    }

    
}
