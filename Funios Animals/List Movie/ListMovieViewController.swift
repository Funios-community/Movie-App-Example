//
//  ListMovieViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class ListMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var loader = MovieLoader()
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        startRefreshing()
        getMovieList()
    }
    
    @objc
    func refresh() {
        bindData(with: [])
        getMovieList()
    }
    
    func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    func stopRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func showErrorLabel(with message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func getMovieList() {
        loader.getMovieList { result in
            self.stopRefreshing()
            switch result {
            case .success(let movies):
                self.bindData(with: movies)
            case .failure(let error):
                self.showErrorLabel(with: error)
            }
        }
    }
    
    func transformJsonDataToMovieList(with data: Data) throws -> [RemoteMovie] {
        let decoder = JSONDecoder()
        let movies = try decoder.decode([RemoteMovie].self, from: data)
        return movies
    }
    
    func bindData(with movies: [Movie]) {
        self.movieList = movies.shuffled()
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
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
        cell.cancelDownloadAndRemoveImage()
    }
    
    func routeToDetailMovie(for movieID: String) {
        let detailVC = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        detailVC.movieID = movieID
        self.show(detailVC, sender: nil)
    }
}

