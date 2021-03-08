//
//  HoursViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class HoursViewController: UIViewController {

    @IBOutlet weak var hoursListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Prochains Horaires"
        
        self.hoursListView.delegate = self
        self.hoursListView.dataSource = self
    }
}

extension HoursViewController : UITableViewDelegate {
    
}

extension HoursViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("HourItem", owner: self, options: nil)?.first as! HourItem
        cell.hourLabel.text = "15h30"
        return cell
    }
    
    
}
