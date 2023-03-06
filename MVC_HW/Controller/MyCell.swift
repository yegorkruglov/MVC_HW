//
//  MyCell.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import UIKit

protocol MyCellDelegate {
    func editCell(cell: MyCell)
    func deleteCell(cell: MyCell)
    func completeCell(cell: MyCell)
}

class MyCell: UITableViewCell {
    
    var delegate: MyCellDelegate?
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        delegate?.completeCell(cell: self)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.deleteCell(cell: self)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        delegate?.editCell(cell: self)
    }
    
}
