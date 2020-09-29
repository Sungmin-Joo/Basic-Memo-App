//
//  MemoDetailViewController.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/30.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.isNavigationBarHidden = true
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = view.backgroundColor
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.barTintColor = view.backgroundColor
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//        self.navigationController?.navigationBar.clipsToBounds = true
//
//


    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
