//
//  LabelDetectionRequestModel.swift
//  TravelGenie
//
//  Created by 서현웅 on 2023/07/22.
//

import Foundation

struct LabelDetectionRequestModel: Encodable {
    let requests: [Request]
}

struct Request: Encodable {
    let content: Content
    let features: [Feature]
    
    enum CodingKeys: String, CodingKey {
        case content = "image"
        case features
    }
}

struct Feature: Encodable {
    let maxResults: Int
    let type: String
    
    init() {
        self.maxResults = 10
        self.type = "LABEL_DETECTION"
    }
}

struct Content: Encodable {
    let base64EncodedImageData: String
    
    enum CodingKeys: String, CodingKey {
        case base64EncodedImageData = "content"
    }
}
