//
//  SecondViewController.swift
//  testGithubApi
//
//  Created by Дмитрий on 07.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var login: String?
    private var currentPage: Int = 1
    private var total: Int = 0
    
    var selectedIndexPath: IndexPath?
    
    var userInfo: UserGitHub? {
        didSet {
            if userInfo != nil {
                
                DispatchQueue.main.async {
                                    
                    self.name.text = self.userInfo!.name
                    self.loginField.text = self.userInfo!.login
                    self.created.text = self.userInfo!.created_at!.getDayMonthYear()
                    self.location.text = self.userInfo!.location
                    self.avatar.image = UIImage (self.userInfo!.avatar_url)
                    
                    self.total = self.userInfo!.public_repos ?? 0
                    
                }
                
            }
        }
    }
    
    var dataRepo = [Repo]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var loginField: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    
    @IBAction func backTouched(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TableViewCellOpenRepo", bundle: nil), forCellReuseIdentifier: "TableViewCellOpenRepo")
        loadAccountInfo()
        
        if #available(iOS 13.0, *) {
            backButton.isHidden = true
        }
        
       
    }
    
    
    private func loadAccountInfo () {
        
        if let login = login {
            NetworkManager.getfullInfoAccountGitHub (login) { info in
                self.userInfo = info
                //https://api.github.com/users/zimoykin/repos
                self.loadPartRepo (login)
            }

        }
    } //loadAccountInfo
    
    private func loadPartRepo (_ login: String ) {
        NetworkManager.getUserRepo(login, page: self.currentPage) { (repos) in
            self.dataRepo += repos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}




//MARK: - TableView
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == selectedIndexPath {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellOpenRepo", for: indexPath) as! TableViewCellOpenRepo
            let item = dataRepo[indexPath.row]
            
            cell.langField.text = item.language
            cell.titleField.text = item.name
            cell.updatedFiled.text = item.updated_at.getDayMonthYear()
            cell.StarCountField.text = "Stars: \(item.stargazers_count)"
            
            return cell
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellRepo", for: indexPath) as! TableViewCellRepo
            let item = dataRepo[indexPath.row]
            
            cell.langField.text = item.language
            cell.titleField.text = item.name
            
            cell.vc = self
            cell.indexPath = indexPath
            
            return cell
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let standartHeight = CGFloat(50)
        
        if indexPath == selectedIndexPath {
            return  3 * standartHeight
        }
        
        
        else {
            return standartHeight
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row == dataRepo.count-1 {
            if total > dataRepo.count {
                currentPage += 1
                if login != nil {
                    loadPartRepo(login!)
                }
            }
        }
    }
    
    
}
