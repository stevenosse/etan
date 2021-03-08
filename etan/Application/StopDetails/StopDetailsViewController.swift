//
//  StopDetailsViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class StopDetailsViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var lineList: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: StopDetailsViewModel!
    
    func configure(viewModel: StopDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var stopName: String
    init(stopName: String) {
        self.stopName = stopName
        super.init(nibName: "StopDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = stopName
        self.lineList.delegate = self
        self.lineList.dataSource = self
        
        setupViewModel()
        setupSearchBar()
        fetchData()
    }
    
    func setupSearchBar() {
        searchbar.delegate = self
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    func setupViewModel() {
        viewModel?.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.lineList.reloadData()
            }
        }
        
    }
    
    func fetchData() {
        self.viewModel?.getStopDetails()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchLine(label: searchText)
    }
}

extension StopDetailsViewController : UITableViewDelegate {
    
}

extension StopDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.lineCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Toutes les lignes"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LineItem", owner: self, options: nil)?.first as! LineItem
        cell.lineNameLabel.text = "Ligne \(viewModel.lines[indexPath.row].numLigne ?? "N\\A")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hoursViewController = HoursViewController()
        let viewModel = HoursViewModel(stop: self.viewModel.stop, line: self.viewModel.lines[indexPath.row])
        hoursViewController.configure(viewModel: viewModel)
        self.navigationController?.pushViewController(hoursViewController, animated: true)
    }
}

extension StopDetailsViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
