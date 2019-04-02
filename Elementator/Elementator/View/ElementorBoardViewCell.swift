//
//  ElementorBoardViewCell.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 02/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//

import UIKit

class ElementorBoardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var selector: UISegmentedControl!
    
    func hideAll() {
        labelText.isHidden = true
        photo.isHidden = true
        selector.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
