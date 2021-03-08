//
//  LineItem.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class LineItem: UITableViewCell {

    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var lineDirectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.lineNameLabel.text = "Ligne C3"
        self.lineDirectionLabel.text = "vers Bd. Doulon"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
