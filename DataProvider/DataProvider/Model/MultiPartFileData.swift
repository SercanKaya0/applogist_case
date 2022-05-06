//
//  MultiPartData.swift
//  DataProvider
//
//  Created by Ercan Garip on 24.12.2021.
//

import Foundation

public enum MultiPartMimeType: String {
    case jpg = "image/jpeg"
    case png = "image/png"
    case mp4 = "video/mp4"
}

public struct MultiPartFileData {
    var data: Data
    var fileName: String
    var key: String
    var mimeType: MultiPartMimeType
    
    public init(data: Data, fileName: String, key: String, mimeType: MultiPartMimeType) {
        self.data = data
        self.fileName = fileName
        self.key = key
        self.mimeType = mimeType
    }
}
