//
//  BaseOptionViewController.swift
//  ExamenParcial
//
//  Created by Kenyi Rodriguez on 11/06/22.
//

import UIKit

class BaseOptionViewController: UIViewController {
 
    @IBAction private func clickBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
