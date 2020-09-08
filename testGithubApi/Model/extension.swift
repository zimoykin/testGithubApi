//
//  extension.swift
//  testGithubApi
//
//  Created by Дмитрий on 08.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func getDayMonthYear() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return "XX-XX-XX"
        }
        
    }
}


extension UIImage {
    
    public convenience init? (_ urlPath: String) {
        
        self.init()
        
        let url = URL(string: urlPath)
        if let url = url {
            let imageData = try? Data(contentsOf: url)
            if let imageData = imageData {
                self.init(data: imageData)
            }
        } else {
            return nil
        }
    }
}


extension UIImageView {

   func rounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
