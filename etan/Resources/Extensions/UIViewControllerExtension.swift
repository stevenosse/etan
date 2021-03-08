//
//  LoadingManager.swift
//  etan
//
//  Created by Nossedjou Steve on 08/03/2021.
//

import Foundation
import UIKit



extension UIViewController {
    func toggleLoadingIndicator(indicator: UIActivityIndicatorView, active: Bool) {
        active
            ? indicator.startAnimating()
            : indicator.stopAnimating()
        indicator.isHidden = !active
    }
    
    func toggleTableViewVisibility(tableView: UITableView, visible: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            tableView.isHidden = !visible
        })
    }
}
