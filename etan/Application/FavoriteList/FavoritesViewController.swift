//
//  FavoritesViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    var viewModel: FavoritesListViewModel = FavoritesListViewModel()
    

    @IBOutlet weak var favoritesListView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Mes arrêts favoris"
        
        self.navigationController?.navigationBar.barTintColor = .white
        favoritesListView.register(UITableViewCell.self,
                             forCellReuseIdentifier: "Cell")
        
        self.noDataLabel.numberOfLines = 0
        self.noDataLabel.textAlignment = .center
        self.noDataLabel.isHidden = true
        
        setupNavbarActions()
        setupTableView()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }

    func setupNavbarActions() {
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(showMapViewTapped))

        navigationItem.rightBarButtonItems = [mapButton]
    }
    
    func setupTableView() {
        self.favoritesListView.delegate = self
        self.favoritesListView.dataSource = self
        
        viewModel.reloadTableViewClosure = { [self] () in
            DispatchQueue.main.async {
                if self.viewModel.favoriteListNames.count == 0 {
                    self.noDataLabel.isHidden = false
                    self.toggleTableViewVisibility(visible: false)
                } else {
                    self.noDataLabel.isHidden = true
                    self.toggleTableViewVisibility(visible: true)
                    self.favoritesListView.reloadData()
                }
            }
        }
    }
    
    @objc func showMapViewTapped() {
        let favoritesView = FavoriteMapViewController()
        self.navigationController?.pushViewController(favoritesView, animated: true)
    }
    
    func fetchData() {
        viewModel.getFavoriteList()
    }
    
    func toggleTableViewVisibility(visible: Bool = false) {
        UIView.animate(withDuration: 0.2, animations: {
            self.favoritesListView.isHidden = !visible
        })
    }
}

extension FavoritesViewController : UITableViewDelegate { }

extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteListNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.favoriteListNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Retirer")  { [self]
            (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if viewModel.removeFromFavorites(name: viewModel.favoriteListNames[indexPath.row]) {
                fetchData()
                Dialog.showMessage(message: "L'élément a été retiré retiré de vos favoris avec succès.", title: "Succès", parent: self)
            } else {
                Dialog.showMessage(message: "L'élément n'a pas pu être retiré.", title: "Erreur", parent: self)
            }
            
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
