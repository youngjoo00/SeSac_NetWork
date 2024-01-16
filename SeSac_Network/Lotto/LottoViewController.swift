//
//  LottoViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/16/24.
//

import UIKit

class LottoViewController: UIViewController {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let numberList: [Int] = Array(1...1102).reversed()
    
    // 1. UIPickerView 생성
    var lottoPickerView = UIPickerView()
    
    var lottoManager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickerView()
        configureUI()
        
        // 3. 로또 뷰를 텍스트 뷰에 삽입
        userTextField.inputView = lottoPickerView
    }
    
}

extension LottoViewController {
    
    func configurePickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    func configureUI() {
        userTextField.placeholder = "여기를 터치해서 로또 회차를 설정하세요"
        resultLabel.text = ""
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.numberOfLines = 0
    }
}

// 2. Delegate, DataSource 설정
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 로또를 가져왔을때 데이터 배열의 개수를 리턴
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
    // 선택한 회차를 resultLabel 에 보여주기
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // 여기서 callRequest 를 호출해서 number 가 넘어가는건 당연한 일
        // 하지만 data 를 넘겨받은 이유는 자세히는 모르겠다..
        self.lottoManager.callRequest(number: numberList[row]) { data in
            self.resultLabel.text = "\(data.drwNo)회차의 당첨 번호는!!?? \n[\(data.drwtNo1) \(data.drwtNo2) \(data.drwtNo3) \(data.drwtNo4) \(data.drwtNo5) \(data.drwtNo6)] Bouns : \(data.bnusNo)"
        }
    }
    
}
