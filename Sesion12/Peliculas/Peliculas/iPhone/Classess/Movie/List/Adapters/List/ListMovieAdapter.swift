//
//  ListMovieAdapter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 18/06/22.
//

import UIKit

protocol ListMovieAdapter {
    var arrayData: [Any] { get set }
    func setTableView(_ tableView: UITableView)
}
