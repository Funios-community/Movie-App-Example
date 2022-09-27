//
//  AnimalCell.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var imageMovieBanner: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelOriginalTitle: UILabel!
    @IBOutlet weak var labelSinopsis: UILabel!

    @IBOutlet weak var imageContainer: UIView!
    
    private var downloadTask: URLSessionDataTask?
    private var movie: Movie!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindData(with movie: Movie) {
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.orginalTitle
        labelSinopsis.text = movie.description
        
        self.movie = movie
    }
    
    func downloadImageKingfisher() {
        imageMovieBanner.kf.setImage(with: self.movie.movieBanner)
    }
    
    func cancelDownloadImageKingfisher() {
        imageMovieBanner.kf.cancelDownloadTask()
        imageMovieBanner.image = nil
    }
    
    func downloadImage() {
        imageContainer.isShimmering = true
        self.downloadTask = URLSession.shared.dataTask(with: movie.movieBanner) { data, response, error in
            DispatchQueue.main.sync {
                self.imageContainer.isShimmering = false
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.imageMovieBanner.image = image
                    }
                }
            }
        }
        self.downloadTask?.resume()
    }
    
    // Loading -> Tampilin Loading
    // Success -> Tampilin Data
    // Failed -> Tampilin Error
    
    func cancelDownloadAndRemoveImage() {
        downloadTask?.suspend()
        downloadTask = nil
        imageMovieBanner.image = nil
    }
}
