//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Tsimafei Zykau on 10/13/19.
//  Copyright © 2019 Timofey Zykov. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    @IBOutlet weak var showMoreButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showMoreButtonTapped(_ sender: UIButton) {
        self.descriptionLabelOutlet.numberOfLines = 0
        self.showMoreButtonOutlet.isHidden = true
    }
}
