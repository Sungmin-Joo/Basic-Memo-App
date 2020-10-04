//
//  NewMemoViewController.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/10/04.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import UIKit

class NewMemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        // Memo 저장
        dismiss(animated: true) {

        }
    }
}
