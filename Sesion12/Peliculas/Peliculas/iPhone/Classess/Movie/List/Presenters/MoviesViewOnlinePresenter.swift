//
//  MoviesViewPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 2/07/22.
//

import Foundation

//MARK: - Propiedades
struct MoviesViewOnlinePresenter {
 
    private unowned let controller: MoviesViewController
    private let webService = MovieWS()
    
    init(controller: MoviesViewController) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MoviesViewOnlinePresenter: MoviesViewPresenter {
    
    func didLoad() {
        self.controller.addPullToRefresh()
        self.controller.setupAdapters()
        self.getAllMovies()
    }
    
    func willAppear() {
        //TODO: Por implementar
    }
    
    func pullToRefresh() {
        self.getAllMovies()
    }
}

//MARK: - Habilidades
extension MoviesViewOnlinePresenter {
    
    private func getAllMovies() {

        self.controller.showLoading(true)
        
        self.webService.getAllMovies { arrayMoviesDTO in
            
            self.controller.showLoading(false)
            let arrayData = arrayMoviesDTO.toMovies
            self.controller.reloadSearchWithData(arrayData)
            self.controller.reloadTableWithData(arrayData)
        }
    }
}
