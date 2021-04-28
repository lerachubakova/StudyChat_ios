//
//  SettingsVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class SettingsVC: BaseVC {

    // MARK: - @IBOutlets
    @IBOutlet private weak var settingsTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    // MARK: - Logic
    private func configureTableView () {
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.settingsTableView.backgroundColor = .clear
        self.settingsTableView.separatorInset = .init(top: 0, left: 50, bottom: 0, right: 0)
        self.settingsTableView.separatorColor = separatorColor
        self.settingsTableView.register(ProfileTVCell.nib(), forCellReuseIdentifier: ProfileTVCell.identifier)
        self.settingsTableView.register(SettingTVCell.nib(), forCellReuseIdentifier: SettingTVCell.identifier)
    }
    
    private func doSetting(_ setting: String) {
        switch setting {
        case "Profile": performSegue(withIdentifier: "toProfileSegue", sender: nil)
        case "Log Out": logOut()
        default: break
        }
    }
    
    private func logOut() {
        performSegue(withIdentifier: "unwindToSignInVCSegue", sender: nil)
    }
    
    // MARK: - @IBActions
    @IBAction private func unwindToSettingsFromProfile(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToSettingsVCSegue" else {return}
        guard segue.destination as? ProfileVC != nil else {return}
    }

}

// MARK: - Extensions
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
           
        switch indexPath.section {
        case 0:
            if let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.identifier) as? ProfileTVCell {
                profileCell.selectionStyle = .none
                profileCell.configure()
                return profileCell
            }
        case 1:
            if let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingTVCell.identifier) as? SettingTVCell {
                settingCell.selectionStyle = .none
                settingCell.configure(setting: settingsList[indexPath.row])
                return settingCell
            }
        default: return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        footerView.backgroundColor = separatorColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: break
        case 1: doSetting(settingsList[indexPath.row].0)
        default: break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // scrollView.contentOffset
    }
    
}
