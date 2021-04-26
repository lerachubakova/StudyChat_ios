//
//  SettingsVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet private weak var settingsTableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView () {
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.settingsTableView.backgroundColor = .clear
        self.settingsTableView.separatorInset = .init(top: 0, left: 50, bottom: 0, right: 0)
    }

}

extension SettingsVC: UITableViewDelegate {}

extension SettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:  cell.backgroundColor = .black
        case 1:  cell.backgroundColor = .white
        default: cell.backgroundColor = .clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        footerView.backgroundColor = UIColor(red: 43/255, green: 46/255, blue: 52/255, alpha: 1)
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // scrollView.contentOffset
    }
    
}
