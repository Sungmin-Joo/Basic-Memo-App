//
//  MemoDataManager.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/28.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import Foundation

final class MemoDataManager {

    static let shared: MemoDataManager = MemoDataManager()
    private init() {
        setupTestData()
    }

    var memoDatas: [MemoModel] = []

    func decodeJsonData<T: Codable>(jsonFileName fileName: String) -> T {
        var data = Data()
        let filename = "\(fileName).json"

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("[Error]: decodeJsonData - Json File Not Found")
        }

        do {
            data = try Data(contentsOf: file)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("[Error]: \(error)")
        }
    }

    func setupTestData() {
        memoDatas = decodeJsonData(jsonFileName: "mockData")
    }
}
