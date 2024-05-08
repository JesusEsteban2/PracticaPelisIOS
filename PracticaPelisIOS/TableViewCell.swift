//
//  TableViewCell.swift
//  PracticaPelisIOS
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render (imagen:String,titulo:String) {
        imageCell.loadImage(fromURL: imagen)
        titleCell.text=titulo
    }

}
