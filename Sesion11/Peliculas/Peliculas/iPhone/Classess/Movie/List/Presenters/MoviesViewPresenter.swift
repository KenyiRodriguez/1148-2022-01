//
//  MoviesViewPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 2/07/22.
//

import Foundation

protocol MoviesViewPresenter {
    func didLoad()
    func willAppear()
    func pullToRefresh()
}

