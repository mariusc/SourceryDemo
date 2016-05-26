//
//  ImageCell.swift
//  SourceryDemo
//
//  Created by Marius Constantinescu on 24/05/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import Sourcery

class ImageCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ImageCell: TableViewPresentable {
    static var staticHeight: CGFloat {
        return 170.0
    }
}
