//
//  MoviesViewLocalPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 2/07/22.
//

import Foundation

//MARK: - Propiedades
struct MoviesViewLocalPresenter {
 
    private unowned let controller: MoviesViewController
    private let localStorage = MovieLS(context: DataManager.current.persistentContainer.viewContext)
    
    init(controller: MoviesViewController) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MoviesViewLocalPresenter: MoviesViewPresenter {

    func didLoad() {
        self.controller.setupAdapters()
    }
    
    func willAppear() {
        self.getAllMovies()
    }
    
    func pullToRefresh() {
        self.getAllMovies()
    }
}

//MARK: - Habilidades
extension MoviesViewLocalPresenter {
    
    private func getAllMovies() {

        let arrayResult = self.localStorage.listAll()
        let arrayData = arrayResult.toMovies
        self.controller.reloadSearchWithData(arrayData)
        self.controller.reloadTableWithData(arrayData.count > 0 ? arrayData : ["Aún no tienes favoritos agregados"])
    }
}
