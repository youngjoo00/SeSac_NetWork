//
//  LottoAPIManager.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/16/24.
//

import UIKit
import Alamofire

struct LottoAPIManager {
    // @escaping 을 사용함으로써 매개변수로 함수를 Lotto 를 넘겨줄 수 있다..?
    func callRequest(number: Int, completionHandler: @escaping (Lotto) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let data):
                // 성공하면 completionHandler 함수 호출
                // 이 데이터는 어떻게 LottoVC 로 날아간거지?
                completionHandler(data)
                print(data)
                
            case .failure(let failure):
                print("그런 회차는 없어요")
            }
        }
    }
    

}
