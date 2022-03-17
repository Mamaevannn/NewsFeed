//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var author: UILabel!
    
   
    func configure(with articles: Article) {
        self.sourceLabel.text = articles.source.name
        self.dateLabel.text = articles.publishedAt
        self.titleLabel.text = articles.title
        self.descriptionLabel.text = articles.description
        self.author.text = articles.author
        
        imageNews.sd_setImage(with: URL(string: articles.urlToImage ?? ""),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
