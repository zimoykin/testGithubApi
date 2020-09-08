//
//  ViewController.swift
//  testGithubApi
//
//  Created by Дмитрий on 07.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var data = [SearchResult]()
    private var currentNumber: Int = 1
    private var total: Int = 0
    
    @IBAction func ButtonTouched(_ sender: UIButton) {
        
//        let login = UserDefaults.standard.string(forKey: "login")
//        let password = UserDefaults.standard.string(forKey: "password")
//
//        guard login != nil || password != nil else {
//            performSegue(withIdentifier: "auth", sender: nil)
//            return
//        }
        
        data = [SearchResult]()
        currentNumber = 1
        
        loadMoreResults()
       
    }
    
    
    func loadMoreResults () {
        
        if let text = searchField.text, text.count > 2 {
            
            view.endEditing(true)
        
            NetworkManager.searchInfoFromServer (key: text.trimmingCharacters(in: .whitespaces), currentNumber) { (total, newData) in
                
                self.total = total
                if let results = newData {
                    
                    for i in results.items {
                        self.data.append(SearchResult(image: UIImage(i.avatar_url)!, user: i))
                        
                        
                    }
                    

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    } //loadMoreResults


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        searchField.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let vc = segue.destination as? SecondViewController, let login = sender as? String? {
                vc.login = login
            }
        }
    }


}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if data.count > 0 {
        let item = data[indexPath.row]
            cell.loginField.text = item.user.login ?? ""
            cell.type.text = item.user.type
            cell.avatar.image = item.image
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if indexPath.row == data.count-1 {
            if total > data.count {
                currentNumber += 1
                loadMoreResults ()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if data.count > 0 {
            let item = data[indexPath.row]
            performSegue(withIdentifier: "detail", sender: item.user.login)
        }
        
    }
    
}



extension FirstViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        currentNumber = 1
        total = 0
        data = [SearchResult]()
        tableView.reloadData()
    }
    
    
}
