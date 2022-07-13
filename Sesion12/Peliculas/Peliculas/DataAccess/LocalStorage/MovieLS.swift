//
//  MovieLS.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 2/07/22.
//

import CoreData

struct MovieLS {
    
    let context: NSManagedObjectContext
    
    func add(_ movie: Movie) {
        let objDM = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: self.context) as? FavoriteMovie
        objDM?.title = movie.title
        objDM?.id = Int32(movie.id)
        objDM?.posterPath = movie.posterPath
        objDM?.voteAverage = Int16(movie.voteAverage)
        objDM?.releaseDate = movie.releaseDate
    }
    
    func searchByKey(_ key: String) -> [FavoriteMovie] {
        let fetchRequest = FavoriteMovie.fetchRequest()
    
        let predicate = NSPredicate(format: "title constains[c] %@", key)
        fetchRequest.predicate = predicate
    
        let sortTitle = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortTitle]
        
        let result = try? self.context.fetch(fetchRequest)
        return result ?? []
    }
    
    func listAll() -> [FavoriteMovie] {
        
        let fetchRequest = FavoriteMovie.fetchRequest()
        
        let sortTitle = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortTitle]
        
        let result = try? self.context.fetch(fetchRequest)
        return result ?? []
    }
    
    //%d -> para int
    //%f -> para float o double
    //%@ -> para objetos
    func getByID(_ idMovie: Int) -> FavoriteMovie? {
        
        let fetchRequest = FavoriteMovie.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %d", idMovie)
        fetchRequest.predicate = predicate
        
        let result = try? self.context.fetch(fetchRequest)
        return result?.first
    }
    
    func delete(_ idMovie: Int) {
        guard let movie = self.getByID(idMovie) else { return }
        self.context.delete(movie)
    }
}
