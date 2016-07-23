//
//  ArticleCollectionViewCell.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var girlDescriptionLabel: UILabel!
    
    @IBOutlet weak var girlImageView: UIImageView!
    
    @IBOutlet weak var contentAnchorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
