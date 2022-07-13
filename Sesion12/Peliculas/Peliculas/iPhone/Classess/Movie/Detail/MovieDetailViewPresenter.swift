//
//  MovieDetailViewPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 9/07/22.
//

import Foundation

//MARK: - Propieadades
class MovieDetailViewPresenter {
    
    private unowned let controller: MovieDetailViewController
    private var movie: Movie?
    
    init(controller: MovieDetailViewController) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MovieDetailViewPresenter {
    func didLoad() {
        self.controller.setupStyle()
        self.getDetail()
        self.setAsFavorite()
    }
    
    func backController() {
        self.controller.backController()
    }
    
    func addToFavorite() {
        
        let dataAccess = MovieLS(context: DataManager.current.persistentContainer.viewContext)
        
        if self.isFavorite {
            dataAccess.delete(self.controller.idMovie)
            DataManager.current.saveContext()
            self.controller.setupFavoriteStyle(false)
            
        } else {
            guard let movie = self.movie else { return }
            dataAccess.add(movie)
            DataManager.current.saveContext()
            self.controller.setupFavoriteStyle(true)
        }
    }
}

//MARK: - Habilidades
extension MovieDetailViewPresenter {
    
    private var isFavorite: Bool {
        let dataAccess = MovieLS(context: DataManager.current.persistentContainer.viewContext)
        let isFavorite = dataAccess.getByID(self.controller.idMovie) != nil
        return isFavorite
    }
    
    private func getDetail() {
        
        let ws = MovieWS()
        
        self.controller.showLoading(true)
        ws.getMovieDetailById(self.controller.idMovie) { movieDTO in
            
            let movie = movieDTO.toMovie
            self.controller.showLoading(false)
            self.controller.updateData(movie)
            self.movie = movie
            
        } error: { errorMessage in
            
            self.controller.showLoading(false)
            print(errorMessage)
        }
    }
    
    private func setAsFavorite() {
        self.controller.setupFavoriteStyle(self.isFavorite)
    }
}
