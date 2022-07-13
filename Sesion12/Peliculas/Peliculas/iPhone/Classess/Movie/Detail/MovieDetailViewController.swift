//
//  MovieDetailViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 25/06/22.
//

import UIKit
import Alamofire

//MARK: - Propieadades
class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var scrollContent: UIScrollView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblGenres: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var imgMovieBackground: UIImageView!
    @IBOutlet private weak var btnFavorite: UIButton!
    @IBOutlet private var arrayStars: [UIImageView]!
    
    var idMovie: Int!
    
    private var presenter: MovieDetailViewPresenter!
}

//MARK: - Ciclo de vida del viewcontroller / usa una contraparte
extension MovieDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
    }
}

//MARK: - Acciones del usuario / usa una contraparte
extension MovieDetailViewController {
    
    @IBAction private func clickBtnBack(_ sender: UIButton) {
        self.presenter.backController()
    }
    
    @IBAction private func clickBtnAddToFavorite(_ sender: UIButton) {
        self.presenter.addToFavorite()
    }
}

//MARK: - Habilidades o capacidades / NO USAMOS CONTRAPARTES
extension MovieDetailViewController {
    
    func backController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupFavoriteStyle(_ isFavorite: Bool) {
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.btnFavorite.setImage(image, for: .normal)
    }
    
    func updateData(_ movie: Movie) {
  
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
    
    func setupStyle() {
        self.imgMovie.layer.cornerRadius = 10
    }
    
    func showLoading(_ isShow: Bool) {
        self.scrollContent.isHidden = isShow
        self.btnFavorite.isHidden = isShow
    }
}

extension MovieDetailViewController {
    
    class func buildWithIdMovie(_ idMovie: Int) -> MovieDetailViewController {
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return MovieDetailViewController()
        }
        
        controller.presenter = MovieDetailViewPresenter(controller: controller)
        controller.idMovie = idMovie
        return controller
    }
}
