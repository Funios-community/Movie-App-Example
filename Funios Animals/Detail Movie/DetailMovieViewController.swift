//
//  DetailMovieViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var movieID: String!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getMovieDetail()
    }
    
    func getMovieDetail() {
        guard let movieID = self.movieID else { return }
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(movieID)")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(RemoteMovieDetail.self, from: data!)
                
                DispatchQueue.main.async { [weak self] in
                    self?.bindData(with: movieDetail)
                }
            } catch let error {
                print("Error \(error)")
            }
        }.resume()
    }

    private func bindData(with movie: RemoteMovieDetail) {
        titleLabel.text = movie.title
        originalTitleLabel.text = "\(movie.originalTitle) \(movie.originalTitleRomanised)"
        let runningTime = convertSecondToHourMinutes(runningTime: movie.runningTime)
        durationLabel.text = runningTime
        releaseDateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.description
        
        downloadImage(with: movie.movieBanner, for: bannerImageView)
        downloadImage(with: movie.image, for: posterImageView)
    }

    private func convertSecondToHourMinutes(runningTime: String) -> String {
        guard let runningTime = Int(runningTime) else { return "\(runningTime) m" }
        return "\(runningTime / 60)h \(runningTime % 60)m"
    }
    
    private func downloadImage(with url: URL, for imageView: UIImageView) {
        let downloadTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            if let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.sync {
                    imageView.image = downloadedImage
                }
            } else {
                print("Error fetching image \(error)")
            }
        }
        downloadTask.resume()
    }
}
