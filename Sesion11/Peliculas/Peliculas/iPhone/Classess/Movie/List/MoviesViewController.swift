//
//  MoviesViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 4/06/22.
//

import UIKit

//MARK: - Propieadades
class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tlvMovies: UITableView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    private var listAdapter: ListMovieAdapter!
    private var searchAdapter: SearchMovieAdapter!
    private var presenter: MoviesViewPresenter!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
}

//MARK: - Ciclo de vida del viewcontroller / usa una contraparte
extension MoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.willAppear()
    }
}

//MARK: - Acciones del usuario / usa una contraparte
extension MoviesViewController {
    
    @IBAction private func pullToRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter.pullToRefresh()
    }
}

//MARK: - Habilidades o capacidades / NO USAMOS CONTRAPARTES
extension MoviesViewController {
    
    func addPullToRefresh() {
        self.tlvMovies.addSubview(self.refreshControl)
    }
    
    func showLoading(_ isLoading: Bool) {
        isLoading ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    func setupAdapters() {
        self.tlvMovies.dataSource = self.listAdapter
        self.tlvMovies.delegate = self.listAdapter
        self.srcMovies.delegate = self.searchAdapter
    }
    
    func goToDetailMovie(_ movie: Movie) {
        let controller = MovieDetailViewController.buildWithIdMovie(movie.id)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func reloadSearchWithData(_ arrayData: [Movie]) {
        self.searchAdapter.arrayData = arrayData
    }
    
    func reloadTableWithData(_ arrayData: [Any]) {
        self.listAdapter.arrayData = arrayData
        self.tlvMovies.reloadData()
    }
}

extension MoviesViewController {
    
    class func buildOnline() -> MoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return MoviesViewController()
        }
        
        controller.listAdapter = ListMovieAdapter(controller: controller)
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.presenter = MoviesViewOnlinePresenter(controller: controller)
        
        controller.tabBarItem.title = "Películas"
        controller.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
        controller.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        
        return controller
    }
    
    class func buildLocal() -> MoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return MoviesViewController()
        }
        
        controller.listAdapter = ListMovieAdapter(controller: controller)
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.presenter = MoviesViewLocalPresenter(controller: controller)
        
        controller.tabBarItem.title = "Favoritos"
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        controller.tabBarItem.image = UIImage(systemName: "star")
        
        return controller
    }
}
