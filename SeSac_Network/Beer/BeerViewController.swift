//
//  BeerViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/16/24.
//

import UIKit
import Alamofire

class BeerViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beerTableView: UITableView!
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        configureUI()
        configureTableView()
    }


}

extension BeerViewController {
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url).responseDecodable(of: [Beer].self) { reponse in
            switch reponse.result {
            case .success(let data):
                self.beerList = data
                self.beerTableView.reloadData()
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    func configureUI() {
        titleLabel.text = "Beer List"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
    }
    
    func configureTableView() {
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        let xib = UINib(nibName: BeerTableViewCell.identifier, bundle: nil)
        beerTableView.register(xib, forCellReuseIdentifier: BeerTableViewCell.identifier)
    }
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beerTableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as! BeerTableViewCell
        
        cell.configureCell(beerList[indexPath.row])
        
        return cell
    }
    
}
