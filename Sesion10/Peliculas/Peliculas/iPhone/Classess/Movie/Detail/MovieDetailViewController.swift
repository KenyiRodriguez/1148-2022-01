//
//  MovieDetailViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 25/06/22.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var scrollContent: UIScrollView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblGenres: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var imgMovieBackground: UIImageView!
    @IBOutlet private var arrayStars: [UIImageView]!
    
    var idMovie: Int!
    
    @IBAction private func clickBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateData(_ movie: Movie) {
  
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseDateFormat
        self.lblGenres.text = movie.genresFormat
        self.lblOverview.text = movie.overview

        for (index, imgStar) in self.arrayStars.enumerated() {
            imgStar.image = UIImage(systemName: index < movie.voteAverage ? "star.fill" : "star")
        }
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            let image = UIImage(data: data)
            self.imgMovie.image = image
            self.imgMovieBackground.image = image
        }
    }
    
    private func showLoading(_ isShow: Bool) {
        self.scrollContent.isHidden = isShow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgMovie.layer.cornerRadius = 10
        self.getDetail()
    }
    
    private func getDetail() {
        
        let ws = MovieWS()
        
        self.showLoading(true)
        
        ws.getMovieDetailById(self.idMovie) { movieDTO in
            
            self.showLoading(false)
            self.updateData(movieDTO.toMovie)
            
        } error: { errorMessage in
            
            self.showLoading(true)
            print(errorMessage)
        }
    }
}

extension MovieDetailViewController {
    
    class func buildWithIdMovie(_ idMovie: Int) -> MovieDetailViewController {
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        controller?.idMovie = idMovie
        return controller ?? MovieDetailViewController()
    }
}
