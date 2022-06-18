//
//  MovieWS.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 14/05/22.
//

import Foundation
import Alamofire

typealias MoviesDTOHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void

struct MovieWS {
    
    func getAllMovies(moviesHandler: @escaping MoviesDTOHandler) {
        
        let urlString =  "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
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
}
