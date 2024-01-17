//
//  TranslationModel.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoHeader
}

struct PapagoHeader: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

// 딕셔너리 상태로 담긴 배열을 만들어야 한다
struct Language {
    
    static let languageList = [
            "ko": "한국어",
            "en": "영어",
            "ja": "일본어",
            "zh-CN": "중국어 간체",
            "zh-TW": "중국어 번체",
            "vi": "베트남어",
            "id": "인도네시아어",
            "th": "태국어",
            "de": "독일어",
            "ru": "러시아어",
            "es": "스페인어",
            "it": "이탈리아어",
            "fr": "프랑스어"
        ]
    
    static let sortedLanguage = Language.languageList.values.sorted()
}
