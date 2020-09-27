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

struct MemoModel: Codable {
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
