//
//  Movie.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 4/06/22.
//

import Foundation

struct Movie {
    
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: Date?
    let title: String
    let voteAverage: Int
    
    var urlImage: String {
        return "https://image.tmdb.org/t/p/w500" + self.posterPath
    }
    
    //Fecha de estreno: Sábado 04 de Junio del 2022
    var releaseDateFormat: String {
        guard let releaseDate = releaseDate else {
            return "Próximamente"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd 'de' MMMM 'del' yyyy"
        dateFormatter.locale = Locale(identifier: "es_pe")
        return dateFormatter.string(from: releaseDate)
    }
    
    init(dto: MovieDTO) {
        self.id = dto.id ?? 0
        self.overview = dto.overview ?? "--"
        self.posterPath = dto.poster_path ?? ""
        self.title = dto.title ?? "--"
        self.voteAverage = Int(dto.vote_average ?? 0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "es_pe")
        self.releaseDate = dateFormatter.date(from: dto.release_date ?? "")
    }
}

extension MovieDTO {
    var toMovie: Movie {
        return Movie(dto: self)
    }
}

extension Array where Element == MovieDTO {
    
    var toMovies: [Movie] {
        self.map({ $0.toMovie })
    }
    
//    var toMovies: [Movie] {
//        var arrayMovies = [Movie]()
//
//        for dto in self {
//            arrayMovies.append(dto.toMovie)
//        }
//
//        return arrayMovies
//    }
}
