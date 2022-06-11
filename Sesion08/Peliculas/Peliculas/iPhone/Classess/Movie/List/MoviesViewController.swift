//
//  MoviesViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 4/06/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tlvMovies: UITableView!
    
    var arrayMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tlvMovies.dataSource = self
        
        let ws = MovieWS()
        ws.getAllMovies { arrayMoviesDTO in
            self.arrayMovies = arrayMoviesDTO.toMovies
            self.tlvMovies.reloadData()
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pepito", for: indexPath) as? MovieTableViewCell
        
        let objMovie = self.arrayMovies[indexPath.row]
        cell?.updateData(objMovie)
        
        return cell ?? UITableViewCell()
    }
    
    
}
