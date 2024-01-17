//
//  LanguageViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet var languageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    

}


extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        let xib = UINib(nibName: LanguageTableViewCell.identifier, bundle: nil)
        languageTableView.register(xib, forCellReuseIdentifier: LanguageTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(Language.languageList.values[0])
        return Language.languageList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languageTableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as! LanguageTableViewCell
        
        cell.configureCell(data: Language.sortedLanguage[indexPath.row])
        
        return cell
    }
    
    
}
