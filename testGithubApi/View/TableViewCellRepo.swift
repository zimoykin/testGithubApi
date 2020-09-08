//
//  TableViewCellRepo.swift
//  testGithubApi
//
//  Created by Дмитрий on 08.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import UIKit

class TableViewCellRepo: UITableViewCell {

    @IBOutlet weak var langField: UILabel!
    @IBOutlet weak var titleField: UILabel!
    
    var vc: SecondViewController?
    var indexPath: IndexPath?
    
    
    @IBAction func openTouched(_ sender: UIButton) {
        
        if let vc = vc, let indePath = indexPath {
            vc.selectedIndexPath = indePath
            vc.tableView.reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
}
