//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    // MARK: - IBoutlet
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var author: UILabel!
    
    private let iso8601Formatter = ISO8601DateFormatter()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = Locale(identifier: "ru_RU_POSIX")
        return formatter
    }()
    
    func configure(with articles: Article) {

        let isoDate = iso8601Formatter.date(from: articles.publishedAt)
        let formattedDate = dateFormatter.string(from: isoDate ?? Date())
        self.dateLabel.text = formattedDate
        self.sourceLabel.text = articles.source.name
        self.titleLabel.text = articles.title
        self.descriptionLabel.text = articles.description
//        self.author.text = articles.author
        
        imageNews.sd_setImage(with: URL(string: articles.urlToImage ?? "https://cdn.pixabay.com/photo/2017/06/10/07/22/news-2389226_1280.png"),
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
