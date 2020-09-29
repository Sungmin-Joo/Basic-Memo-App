
//
//  HomeViewModel.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/22.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import RxSwift

final class HomeViewModel: ViewDataContainable {

    enum HomeSectionType: Int, CaseIterable {
        case pinned
        case list
    }

    let searchResultCellModels = BehaviorSubject<[MemoCellModel]>(value: [])
    private var cellModels: [HomeSectionType: [CellDataContainable]] = [:]
    private var preSearchData: String?
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

extension HomeViewModel: SearchDataContainable {

    func clearSearchResult() {
        searchResultCellModels.onNext([])
    }

    func didChangeSearchText(_ text: String) {
        let searchText = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard preSearchData != searchText else {
            return
        }
        preSearchData = searchText

        // 태그와 제목 검색
        // 결과 데이터는 시간순 정렬

        let searchResult = MemoDataManager.shared.memoDatas
            .filter { $0.title.lowercased().components(separatedBy: " ").contains(find: searchText) }
            .sorted { $0 < $1 }


        // 추후 set 사용하여 통합
        let tagResult = MemoDataManager.shared.memoDatas
            .filter { $0.tag.map { $0.lowercased() }.contains(find: searchText) }
            .sorted { $0 < $1 }


        searchResultCellModels.onNext(
            searchResult.map { MemoCellModel(text: $0.title) }
        )
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

        cellModels[.list] = MemoDataManager.shared.memoDatas
            .map { MemoCellModel(text: $0.title) }

        cellModels[.pinned] = MemoDataManager.shared.memoDatas
            .filter {$0.isPinned }
            .map { MemoCellModel(text: $0.title) }

        didFetchViewData?()
    }

}

private extension BidirectionalCollection where Element: StringProtocol {

    func contains(find: Element) -> Bool {

        for word in self {
            if (word.range(of: find) != nil) {
                return true
            }
        }

        return false
    }

}
