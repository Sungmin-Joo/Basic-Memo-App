//
//  ViewController.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/22.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import UIKit

protocol SearchResultPresentable {
    /// 검색 시작 전 검색결과 TableView 노출
    func searchWillStart() -> Void
    /// 검색 중 텍스트 변경
    /// - Parameter text: 유효한 검색어를 전달
    func searchResultWillChange(text: String) -> Void
    /// 검색 종료 후 검색결과 TableView 숨기고 메인 CollectionView 노출
    func searchDidEnd() -> Void
}

final class HomeViewController: UIViewController {
    typealias ViewModelType = ViewDataContainable & ListDataContainable
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ViewModelType = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFloatingView()
        setupNavigationBar()
        setupTableView()
        setupCompletion()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            HUDManager.shared.colorAppearanceDidChange()
        }
    }
}

// MARK: - Setup
extension HomeViewController {

    private func setupFloatingView() {

        let newMemoImage = HomeConst.Image.newMemo.getImage()
        let newMemoButton = UIButton()
        newMemoButton.setImage(newMemoImage, for: .normal)

        let newForderImage = HomeConst.Image.newFolder.getImage()
        let newForderButton = UIButton()
        newForderButton.setImage(newForderImage, for: .normal)

        // 상단 네비게이션 바 때문에 HUDManager 사용
        HUDManager.shared.showFloatingView(menuButtons: [
            newMemoButton,
            newForderButton
        ])
    }

    private func setupNavigationBar() {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = HomeConst.Text.search.rawValue
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        navigationItem.titleView = searchBar
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(MemoCell.self,
                           forCellReuseIdentifier: HomeConst.Identifier.memo.rawValue)
        tableView.register(BaseCell.self,
                           forCellReuseIdentifier: HomeConst.Identifier.base.rawValue)
    }

    private func setupCompletion() {

        viewModel.didFetchViewData = { [weak self] in
            self?.tableView.reloadData()
        }

        // For test
        guard let testViewModel = viewModel as? HomeViewModel else {
            return
        }

        testViewModel.setupTestData()
    }
}

// MARK: - Action
extension HomeViewController {

    @objc func searchButtonPressed(_ sender: Any) {

    }

    @objc func menuButtonPressed(_ sender: Any) {

    }
}

// MARK: - Constant
enum HomeConst {

    enum Font {
        static let textFont: UIFont = .systemFont(ofSize: 19, weight: .regular)
    }

    enum Height {
        static let textLabel: CGFloat = 19.0
    }

    enum Text: String {
        case search = "Search"
    }

    enum Identifier: String {
        case base = "Base"
        case memo = "MemoCell"
    }

    enum Image: CaseIterable {
        case newMemo
        case newFolder

        func getImage() -> UIImage? {
            switch self {
            case .newMemo:
                return UIImage(systemName: "pencil")
            case .newFolder:
                return UIImage(systemName: "folder.badge.plus")
            }
        }
    }
}
