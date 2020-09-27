//
//  HomeViewController+SearchPhase.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/22.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import UIKit

extension HomeViewController: SearchResultPresentable {

    func searchWillStart() {

    }

    func searchResultWillChange(text: String) {

    }

    func searchDidEnd() {

    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchWillStart()
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = .none
        searchDidEnd()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 짤로 내가 짰던거 보고 참고

        guard !searchText.isEmpty else {
            searchBar.setShowsCancelButton(false, animated: true)
            return
        }
        searchBar.setShowsCancelButton(true, animated: true)
        searchResultWillChange(text: searchText)
    }
}
