//
//  MoviesViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 4/06/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tlvMovies: UITableView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    lazy var listAdapter = ListMovieAdapter(controller: self)
    
    lazy var searchAdapter: SearchMovieAdapter = {
        let adapter = SearchMovieAdapter(controller: self)
        return adapter
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tlvMovies.addSubview(self.refreshControl)
        self.setupAdapters()
        self.getAllMovies()
    }
    
    @objc private func pullToRefresh(_ refreshControl: UIRefreshControl) {
        self.getAllMovies()
    }
    
    private func setupAdapters() {
        
        self.tlvMovies.dataSource = self.listAdapter
        self.tlvMovies.delegate = self.listAdapter
        self.srcMovies.delegate = self.searchAdapter
    }
    
    private func getAllMovies() {
        
        let ws = MovieWS()
        ws.getAllMovies { arrayMoviesDTO in
            
            self.refreshControl.endRefreshing()
            let arrayData = arrayMoviesDTO.toMovies
            self.listAdapter.arrayData = arrayData
            self.searchAdapter.arrayData = arrayData
            self.tlvMovies.reloadData()
        }
    }
    
    func goToDetailMovie(_ movie: Movie) {
        print("Vamos al detalle de: " + movie.title)
    }
    
    func reloadTableWithData(_ arrayData: [Any]) {
        self.listAdapter.arrayData = arrayData
        self.tlvMovies.reloadData()
    }
}
