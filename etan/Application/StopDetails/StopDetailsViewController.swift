//
//  StopDetailsViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class StopDetailsViewController: UIViewController {
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var lineList: UITableView!
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
    }
}

extension StopDetailsViewController : UITableViewDelegate {
    
}

extension StopDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Toutes les lignes"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LineItem", owner: self, options: nil)?.first as! LineItem
        return cell
    }
    
    
}
