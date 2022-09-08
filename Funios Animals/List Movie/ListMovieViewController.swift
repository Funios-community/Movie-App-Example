//
//  ListMovieViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class ListMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movieList: [RemoteMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        getMovieList()
    }
    
    func getMovieList() {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
     
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([RemoteMovie].self, from: data!)
                
                self.bindData(with: movies)
                
            } catch {
                print("Error \(error)")
            }
        }.resume()
    }
    
    func bindData(with movies: [RemoteMovie]) {
        DispatchQueue.main.async {
            self.movieList = movies
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.bindData(with: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        routeToDetailMovie(for: movieList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieCell
        cell.downloadImage()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! MovieCell
        cell.cancelDownloadRemoveImage()
    }
    
    func routeToDetailMovie(for movieID: String) {
        let detailVC = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        detailVC.movieID = movieID
        self.show(detailVC, sender: nil)
    }
}

