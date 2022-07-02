//
//  MovieWS.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 14/05/22.
//

import Foundation
import Alamofire

typealias MoviesHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void
typealias MovieHandler = (_ movieDTO: MovieDTO) -> Void
typealias ErrorHandler = (_ errorMessage: String) -> Void

struct MovieWS {
    
    func getAllMovies(moviesHandler: @escaping MoviesHandler) {
        
        let urlString =  "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
        let request = AF.request(urlString, method: .get)
        
        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                moviesHandler([])
                return
            }
            
            let decoder = JSONDecoder()
            let response = try? decoder.decode(PageMovieDTO.self, from: data)
            let arrayMovies = response?.results ?? []
            moviesHandler(arrayMovies)
        }
    }
    
    func getMovieDetailById(_ idMovie: Int, success: @escaping MovieHandler, error: @escaping ErrorHandler) {
        
        let urlString =  "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
        let request = AF.request(urlString, method: .get)
        
        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                error("Se encontro un error en la conexión. Intentelo más tarde.")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try? decoder.decode(MovieDTO.self, from: data)
            
            guard let response = response else {
                error("No se puede leer la información.")
                return
            }
            
            success(response)
        }
    }
}
