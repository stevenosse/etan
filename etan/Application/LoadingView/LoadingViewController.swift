//
//  LoadingViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingLabel.text = "Chargement..."
        perform(#selector(navigateToMainScreen), with: nil, afterDelay: 0.5)
    }

    @objc func navigateToMainScreen() {
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
}
