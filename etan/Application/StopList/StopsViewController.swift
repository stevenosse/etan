//
//  StopsViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class StopsViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stopsListView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Arrêts"
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTableView() {
        self.stopsListView.delegate = self
        self.stopsListView.dataSource = self
    }
}

extension StopsViewController : UITableViewDelegate {
    
}

extension StopsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("StopItem", owner: self, options: nil)?.first as! StopItem
        cell.stopNameLabel.text = "Angevinière"
        cell.distanceLabel.text = "500m"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let hoursAction = _buildImportantAction(at: indexPath.row)
        return UISwipeActionsConfiguration(actions: [hoursAction])
    }
    
    func _buildImportantAction(at: Int) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Pr. Horaires") {
            (action, view, completer) in
            // TODO: provide stop info
            self.navigationController?.pushViewController(HoursViewController(), animated: true)
        }
        
        return action
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO: change this title on search
        return "Tous les arrêts"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = .white
            view.textLabel?.backgroundColor = .clear
            view.textLabel?.textColor = .black
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(StopDetailsViewController(stopName: "Angevinière"), animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
}
