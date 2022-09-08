//
//  DetailMovieViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var id: String?
    
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
        let url = URL(string: "https://ghibliapi.herokuapp.com/films/\(id)")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(RemoteMovie.self, from: data!)
                
                //binding data detail
                self.bindData(movie: movie)
            } catch {
                print("Error \(error)")
            }
        }.resume()
    }

    func bindData(movie: RemoteMovie) {
//        bannerImageView.image = movie.movieBanner
//        posterImageView.image = movie.moviePoster
//        titleLabel.text = movie.title
//        originalTitleLabel.text = movie.orginalTitle
//        durationLabel.text = movie.formattedDuration
//        releaseDateLabel.text = movie.releaseDate
//        descriptionLabel.text = movie.description
    }

    private func convertSecondToHourMinutes(runningTime: String) -> String {
        guard let runningTime = Int(runningTime) else { return "\(runningTime) m" }
        return "\(runningTime / 60)h \(runningTime % 60)m"
}
