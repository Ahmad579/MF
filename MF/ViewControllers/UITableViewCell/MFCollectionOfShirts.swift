//
//  MFCollectionOfShirts.swift
//  MF
//
//  Created by Ahmed Durrani on 04/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

protocol ISFavouriteORNot {
    func isFavOrUnFav(checkCell : MFCollectionOfShirts , indexPath : IndexPath)
    func shareShirtOnFb(checkCell : MFCollectionOfShirts , indexPath : IndexPath)

    
}


class MFCollectionOfShirts: UITableViewCell {

    var delegate: ISFavouriteORNot?
    var index: IndexPath?

    @IBOutlet var viewOfLikeOrDislike: UIView!
    @IBOutlet var btnIsLike: UIButton!
    @IBOutlet var btnShare: UIButton!

    @IBOutlet var imageOfCollections: UIImageView!
    
    @IBOutlet var lblLike: UILabel!
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
        self.delegate?.isFavOrUnFav(checkCell : self  , indexPath : index!)
        
        
    }
    
    @IBAction func btnShare_Pressed(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        self.delegate?.shareShirtOnFb(checkCell : self  , indexPath : index!)
        
        
    }
}
