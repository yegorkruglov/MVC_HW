//
//  MyCell.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import UIKit

class MyCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
