//
//  StopItem.swift
//  etan
//
//  Created by Nossedjou Steve on 04/03/2021.
//

import UIKit

class StopItem: UITableViewCell {

    @IBOutlet weak var stopNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
