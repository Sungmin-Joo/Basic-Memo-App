
//
//  HomeViewModel.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/22.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import Foundation

final class HomeViewModel: ViewDataContainable {

    enum HomeSectionType: Int, CaseIterable {
        case pinned
        case list
    }

    private var cellModels: [HomeSectionType: [CellDataContainable]] = [:]
    var didFetchViewData: (() -> Void)?

}

extension HomeViewModel: ListDataContainable {

    var numberOfSections: Int {
        return HomeSectionType.allCases.count
    }


    func titleForSection(_ section: Int) -> String? {
        guard let sectionType = HomeSectionType.init(rawValue: section) else {
            return .none
        }

        switch sectionType {
        case .pinned:
            return "Pinned"
        case .list:
            return "Memo"
        }
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let sectionType = HomeSectionType.init(rawValue: section) else {
            return 0
        }

        return cellModels[sectionType]?.count ?? 0
    }

    func cellModelForRowAt(_ indexPath: IndexPath) -> CellDataContainable? {
        guard
            let sectionType = HomeSectionType.init(rawValue: indexPath.section) else {
            return nil
        }

        return cellModels[sectionType]?[safe: indexPath.row]
    }
}

// MARK: - 테스트 데이터 용 함수
extension HomeViewModel {
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
        let testModel: [MemoModel] = decodeJsonData(jsonFileName: "mockData")
        debugPrint(testModel)
        cellModels[.list] = testModel.map { MemoCellModel(text: $0.title) }
        cellModels[.pinned] = testModel.filter { $0.isPinned }
            .map { MemoCellModel(text: $0.title) }
        didFetchViewData?()
    }

}
