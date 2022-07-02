//
//  SearchAdapter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 18/06/22.
//

import UIKit

class SearchMovieAdapter: NSObject {
    
    private unowned let controller: MoviesViewController
    var arrayData = [Movie]()
    
    init(controller: MoviesViewController) {
        self.controller = controller
    }
}

extension SearchMovieAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            self.controller.reloadTableWithData(self.arrayData)
            
        } else {
            
            let result = self.arrayData.filter { movie in
                let name = movie.title.lowercased()
                let text = searchText.lowercased()
                return name.contains(text)
            }
            
            let arrayToShow: [Any] = result.count != 0 ? result : ["No se encontraron resultado para la búsqueda de:\n\n\(searchText)"]
            
            self.controller.reloadTableWithData(arrayToShow)
        }
    }
}
