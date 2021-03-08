//
//  HoursViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class HoursViewController: UIViewController {
    var viewModel: HoursViewModel?
    
    @IBOutlet weak var hoursListView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Prochains Horaires"
        
        self.hoursListView.delegate = self
        self.hoursListView.dataSource = self
        
        self.errorMessageLabel.isHidden = true
        self.noDataLabel.isHidden = true
        
        setupViewModel()
        fetchData()
    }
    
    public func configure(viewModel: HoursViewModel) {
        self.viewModel = viewModel
    }
    
    func setupViewModel() {
        viewModel?.errorLoadingDataClosure = { [self, viewModel] in
            DispatchQueue.main.async {
                self.errorMessageLabel.text = viewModel?.errorMessage
                self.errorMessageLabel.isHidden = false
                self.toggleLoadingIndicator(active: false)
            }
        }
        
        viewModel?.reloadTableViewClosure = { [self] () in
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = true
                
                if self.viewModel?.hourList.count == 0 {
                    self.noDataLabel.isHidden = false
                    toggleTableViewVisibility(visible: false)
                } else {
                    self.noDataLabel.isHidden = true
                    self.hoursListView.reloadData()
                }
            }
        }
        
        viewModel?.updateLoadingStatusClosure = { [self] () in
            DispatchQueue.main.async {
                let isLoading = self.viewModel?.isLoading
                if isLoading! {
                    self.toggleLoadingIndicator(active: true)
                    self.toggleTableViewVisibility(visible: false)
                } else {
                    self.toggleLoadingIndicator(active: false)
                    self.toggleTableViewVisibility(visible: true)
                }
            }
        }
    }
    
    
    func toggleLoadingIndicator(active: Bool = false) {
        active
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = !active
    }
    
    
    func toggleTableViewVisibility(visible: Bool = false) {
        UIView.animate(withDuration: 0.2, animations: {
            self.hoursListView.isHidden = !visible
        })
    }
    
    func fetchData() {
        viewModel?.getNextHours()
    }
}

extension HoursViewController : UITableViewDelegate {
    
}

extension HoursViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.hourList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("HourItem", owner: self, options: nil)?.first as! HourItem
        cell.hourLabel.text = viewModel?.hourList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
