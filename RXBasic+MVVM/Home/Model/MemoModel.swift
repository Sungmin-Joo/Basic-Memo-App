//
//  MemoModel.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/22.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import Foundation

protocol Storable {
    func getMemoPath() -> String
}

struct MemoModel: Codable, Hashable {
    let id: Int
    var savedDate: String
    var title: String
    var body: String
    var tag: [String]
    var isPinned: Bool
    var pinnedIndex: Int
}

extension MemoModel: Storable {

    func getMemoPath() -> String {
        return ""
    }

}

extension MemoModel: Comparable {
    static func < (lhs: MemoModel, rhs: MemoModel) -> Bool {
        guard
            let lhsData = lhs.savedDate.toDate(),
            let rhsData = rhs.savedDate.toDate() else {
                return false
        }

        return lhsData.compare(rhsData) == ComparisonResult.orderedDescending
    }
}

private extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        return formatter.date(from: self)
    }
}
