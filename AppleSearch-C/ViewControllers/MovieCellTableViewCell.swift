//
//  MovieCellTableViewCell.swift
//  AppleSearch-C
//
//  Created by Chris Anderson on 12/6/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    // MARK: - Properties
    
    var movie: CDAMovie? {
        didSet {
            guard let movie = movie else { return }
            
            CDAMovieController.fetchImage(for: movie) { (image) in
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                    self.titleLabel.text = movie.title
                    self.ratingLabel.text = "\(movie.vote_average)"
                    self.overviewLabel.text = movie.overView
                }
            }
            
        }
    }

}
