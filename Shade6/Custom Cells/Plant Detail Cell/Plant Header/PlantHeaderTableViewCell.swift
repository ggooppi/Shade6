//
//  PlantHeaderTableViewCell.swift
//  Shade6
//
//  Created by gopinath.a on 02/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit
import SDWebImage

class PlantHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var plantImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(imageURL: String) -> Void {
        plantImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "NoImage"))
    }
    
}
