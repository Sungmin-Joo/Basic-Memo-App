//
//  Protocols.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/23.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import Foundation

// TODO: - ViewModel 프로토콜 이름 개선
protocol ViewDataContainable {
    var didFetchViewData: (() -> Void)? { get set }
}

protocol ListDataContainable {
    var numberOfSections: Int { get }
    func titleForSection(_ section: Int) -> String?
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellModelForRowAt(_ indexPath: IndexPath) -> CellDataContainable?
}

// TODO: - CellViewModel 프로토콜 이름 개선
protocol CellDataContainable {
    var reuseIdentifier: String { get }
}

// TODO: - ViewModel을 가질 수 있는 프로토콜 이름 개선
protocol ViewModelBindable {
    var viewModel: CellDataContainable? { get set }
    func didSetViewModel(_ viewModel: CellDataContainable?)
}
