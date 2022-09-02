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

    private var downloadTask: URLSessionDataTask?
    private var movie: RemoteMovie!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindData(with movie: Movie) {
        imageMovieBanner.image = movie.movieBanner
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.orginalTitle
        labelSinopsis.text = movie.description
    }
    
    func bindData(with movie: RemoteMovie) {
        labelMovieTitle.text = movie.title
        labelOriginalTitle.text = movie.originalTitle
        labelSinopsis.text = movie.remoteMovieDescription
        
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
        downloadTask = URLSession.shared.dataTask(with: self.movie.movieBanner) { data, response, error in
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.sync {
                    self.imageMovieBanner.image = image
                }
            } else {
                print("Error fetching image \(error)")
            }
        }
        downloadTask?.resume()
    }
    
    func cancelDownloadRemoveImage() {
        downloadTask?.suspend()
        downloadTask = nil
        imageMovieBanner.image = nil
    }
}
