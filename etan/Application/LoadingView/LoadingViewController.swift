//
//  LoadingViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: LoadingViewModel = {
        return LoadingViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingLabel.text = "Initialisation de l'application. \nCette opération peut durer quelques minutes..."
        activityIndicator.startAnimating()
         initializeApplication()
    }
    
    func initializeApplication() {
        viewModel.initStopList() {
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                self.navigateToMainScreen()
            }
        }
    }

    func navigateToMainScreen() {
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
}
