//
//  TableViewCellOpenRepo.swift
//  testGithubApi
//
//  Created by Дмитрий on 08.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import UIKit

class TableViewCellOpenRepo: UITableViewCell {
    
    
    @IBOutlet weak var langField: UILabel!
    
    @IBOutlet weak var titleField: UILabel!
    
    @IBOutlet weak var StarCountField: UILabel!
    
    @IBOutlet weak var updatedFiled: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
