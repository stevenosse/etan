//
//  StopsViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class StopsViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stopsListView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)

    lazy var viewModel: StopListViewModel = {
        return StopListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Arrêts"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = true
        
        self.errorMessageLabel.isHidden = true
        self.noDataLabel.isHidden = true
        
        setupSearchBar()
        setupTableView()
        setupViewModel()
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchStop(label: searchText)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    func setupTableView() {
        self.stopsListView.delegate = self
        self.stopsListView.dataSource = self
    }
    
    // MARK: - Setup viewModel
    func setupViewModel() {
        viewModel.errorLoadingDataClosure = { [self, viewModel] () in
            DispatchQueue.main.async {
                self.errorMessageLabel.text = viewModel.errorMessage
                self.errorMessageLabel.isHidden = false
                self.toggleLoadingIndicator(indicator: activityIndicator, active: false)
            }
        }
        viewModel.reloadTableViewClosure = { [self] () in
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = true
                
                if self.viewModel.stopCount == 0 {
                    self.noDataLabel.isHidden = false
                    self.stopsListView.isHidden = true
                } else {
                    self.noDataLabel.isHidden = true
                    self.stopsListView.isHidden = false
                    self.stopsListView.reloadData()
                }
                
            }
        }
        viewModel.updateLoadingStatusClosure = { [self] () in
            DispatchQueue.main.async {
                let isLoading = self.viewModel.isLoading
                if isLoading {
                    self.toggleLoadingIndicator(indicator: self.activityIndicator, active: true)
                    self.toggleTableViewVisibility(tableView: self.stopsListView, visible: false)
                } else {
                    self.toggleLoadingIndicator(indicator: self.activityIndicator, active: false)
                    self.toggleTableViewVisibility(tableView: self.stopsListView, visible: true)
                }
            }
        }
    }
    
    func fetchData() {
        self.viewModel.getStopList()
    }
}

// MARK: - Table view Delegate
extension StopsViewController : UITableViewDelegate {
    
}

// MARK: - Table view data source
extension StopsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: move this to it component
        let cell = Bundle.main.loadNibNamed("StopItem", owner: self, options: nil)?.first as! StopItem
        cell.stopNameLabel.text = "\(viewModel.stopList?[indexPath.row].libelle ?? "Aucun libelle")"
        cell.distanceLabel.text = "N\\A"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO: change this title on search
        return "Tous les arrêts"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel: StopDetailsViewModel = StopDetailsViewModel(stop: self.viewModel.stopList?[indexPath.row])
        let stopDetailsVC = StopDetailsViewController(stopName: viewModel.stopName)
        stopDetailsVC.configure(viewModel: viewModel)
        self.navigationController?.pushViewController(stopDetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.stopCount
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addToFavoritesAction = UIContextualAction(style: .normal, title: "Ajouter au favoris") { [self]
            (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let savedStatus = self.viewModel.saveStopToFavorites(stop: self.viewModel.stopList?[indexPath.row])
            if savedStatus {
                Dialog.showMessage(message: "L'arrêt a été ajouté à vos favoris avec succès.", title: "Succès", parent: self)
            } else {
                Dialog.showMessage(message: "L'arrêt n'a pas pu être ajouté à vos favoris (ou y est déjà).", title: "Erreur", parent: self)
            }
            success(true)
        }
        addToFavoritesAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [addToFavoritesAction])
    }
}
