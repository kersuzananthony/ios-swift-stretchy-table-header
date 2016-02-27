//
//  CustomTableViewCell.swift
//  Table View Header Test
//
//  Created by Kersuzan on 28/12/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var title: String!
    var subTitle: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(item: Item) {
        self.titleLabel.text = item.title
        self.subTitleLabel.text = item.subTitle
    }
    
}
