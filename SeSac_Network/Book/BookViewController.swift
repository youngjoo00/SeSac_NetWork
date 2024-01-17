//
//  BookViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit
import Alamofire

class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookCollectionView: UICollectionView!
    
    var bookData: [Document] = [] {
        didSet {
            bookCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureCollectionView()
    }
}

extension BookViewController {
    
    func configureView() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "원하시는 책을 검색해보세요"
    }
    
    func callRequest(text: String) {
        
        //만약 한글 검색이 안된다면 인코딩 처리
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        // headers 는 타입이 HTTPHeaders 라서 어노테이션으로 직접 입력해주자
        let headers: HTTPHeaders = ["Authorization" : APIKey.kakaoKey,
        ]
        
        // parameter 에는 딕셔너리 형태의 Http.Body에 넣어서 보낼 값들을 넣는다.
        // header 도 마찬가지
        AF.request(url, headers: headers)
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let data):
                    print(data.documents)
                    
                    // 이미지 값이 없다면 배열에 안넣는 기능 필요!!!!!!!
                    self.bookData = data.documents
                case .failure(let fail):
                    print(fail)
                }
            }
    }

}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let xib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        
        // 디바이스 기준으로 가로 길이를 잡아놓고,
        // 가로 길이에 맞춰서 세로길이를 맞추면 셀이 1:1 비율로 나올수밖에 없음 -> 즉, 이미지만 1:1 비율로 나오는거임
        // 그러니까 가로길이에 * 1.2 ~ 1.5 배로 준다면 1:1.5 이런 형식의 가로세로 비율의 셀이 나와서 이쁘게 레이아웃이 잡힘
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        let cellhieght = ((UIScreen.main.bounds.width - (spacing * 3)) * 1.5) / 3
        
        layout.itemSize = CGSize(width: cellWidth, height: cellhieght)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        bookCollectionView.collectionViewLayout = layout

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        cell.configureCell(data: bookData[indexPath.row])
        return cell
    }
    
    
}
