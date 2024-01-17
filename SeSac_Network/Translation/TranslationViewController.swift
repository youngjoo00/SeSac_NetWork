//
//  TranslationViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit
import Alamofire

class TranslationViewController: UIViewController {

    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateBtn: UIButton!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var beforeTransBtn: UIButton!
    @IBOutlet var swapBtn: UIButton!
    @IBOutlet var afterTransBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
   
}

extension TranslationViewController {
    
    func configureView() {
        sourceTextView.text = ""
        sourceTextView.layer.borderWidth = 1
        
        translateBtn.setTitle("번역하기", for: .normal)
        translateBtn.setTitleColor(.black, for: .normal)
        translateBtn.backgroundColor = .gray
        targetLabel.text = ""
        
        beforeTransBtn.setTitle("한국어", for: .normal)
        beforeTransBtn.setTitleColor(.black, for: .normal)
        
        swapBtn.setTitle("", for: .normal)
        swapBtn.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        swapBtn.tintColor = .black
        
        afterTransBtn.setTitle("영어", for: .normal)
        afterTransBtn.setTitleColor(.black, for: .normal)
        
        translateBtn.addTarget(self, action: #selector(translateBtnClicked), for: .touchUpInside)
        beforeTransBtn.addTarget(self, action: #selector(beforeTransBtnClicked), for: .touchUpInside)
        afterTransBtn.addTarget(self, action: #selector(afterTransBtnClicked), for: .touchUpInside)
    }
    
    @objc func beforeTransBtnClicked() {
        let vc = storyboard?.instantiateViewController(identifier: LanguageViewController.identifier) as! LanguageViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func afterTransBtnClicked() {
        let vc = storyboard?.instantiateViewController(identifier: LanguageViewController.identifier) as! LanguageViewController

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func translateBtnClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        // headers 는 타입이 HTTPHeaders 라서 어노테이션으로 직접 입력해주자
        let headers: HTTPHeaders = ["X-Naver-Client-Id" : APIKey.clientID,
                                    "X-Naver-Client-Secret" : APIKey.clientSecret
        ]
        
        let parameters : Parameters = ["text" : sourceTextView.text!,
                                       "source" : "ko",
                                       "target" : "en"
        ]
        
        // parameter 에는 딕셔너리 형태의 Http.Body에 넣어서 보낼 값들을 넣는다.
        // header 도 마찬가지
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: Papago.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    
                    self.targetLabel.text = data.message.result.translatedText
                case .failure(let fail):
                    print(fail)
                }
            }
    }
}
