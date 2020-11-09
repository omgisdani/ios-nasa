//
//  FechaCell.swift
//  nasa
//
//  Created by dani v on 06/11/20.
//

import UIKit

class FechaCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg.layer.cornerRadius = 15
        bg.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
