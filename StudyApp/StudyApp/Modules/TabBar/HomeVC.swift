//
//  HomeVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak private var navigationBar: UINavigationBar!
    @IBOutlet weak private var profileImageView: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBar.transparent()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImageView.image = UIImage(named: "imgSomeUser")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
