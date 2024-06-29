//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    private var savedUserImageIndex = UserDefaults.standard.integer(forKey: "userImageIndex")
    private var savedUserName = UserDefaults.standard.string(forKey: "userNickname")
    private let optionList = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    private let headerView = UIView()
    private lazy var userImageView = Profile().currentAvatars[savedUserImageIndex]
    
    private lazy var nicknameLabel = {
        let label = UILabel()
        label.font = Meaning.Font.heavy20
        label.textColor = .black
        label.text = savedUserName
        return label
    }()
    
    private let signUpDateLabel = {
        let label = UILabel()
        label.text = (UserDefaults.standard.string(forKey: "userJoinDate") ?? "0000.00.00") + " 가입"
        label.font = Meaning.Font.regular15
        label.textColor = Meaning.Color.gray2
        return label
    }()
    
    private let rightImageView = {
        let imageView = UIImageView()
        imageView.image = Meaning.Image.right
        imageView.tintColor = Meaning.Color.gray2
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        settingNavigation(title: "SETTING", rightBarItem: nil)
        
        view.backgroundColor = Meaning.Color.background
        userImageView.image = userImageView.getUserImage()
        configureSetting()
        configureHierarchy()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "isModified") {
            nicknameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
            userImageView.image = userImageView.getUserImage()
            UserDefaults.standard.set(false, forKey: "isModified")
        }
        UserDefaults.standard.set(false, forKey: "isModified")
    }
    
    override func viewWillLayoutSubviews() {
        userImageView.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.clipsToBounds = true
    }
}

extension SettingViewController {
    private func configureSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        tableView.separatorColor = .black
        
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerViewClicked)))
    }
    
    @objc func headerViewClicked() {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    private func configureHierarchy() {
        [headerView, tableView].forEach { view.addSubview($0) }
        [userImageView, nicknameLabel, signUpDateLabel, rightImageView].forEach {
            headerView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(tableView)
            $0.height.equalTo(120)
        }
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.leading.equalTo(headerView.snp.leading).inset(10)
            $0.size.equalTo(80)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.bottom.equalTo(headerView.snp.centerY).inset(3)
            $0.leading.equalTo(userImageView.snp.trailing).offset(20)
        }

        signUpDateLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.centerY).offset(3)
            $0.leading.equalTo(nicknameLabel)
        }
        
        rightImageView.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.trailing.equalTo(headerView).inset(10)
            $0.size.equalTo(17)
        }
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.textLabel?.text = optionList[indexPath.row]
        cell.textLabel?.font = Meaning.Font.medium15
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if optionList[indexPath.row] != "탈퇴하기" { return nil }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: "탈퇴하기", message: "탈퇴 시 데이터가 모두 초기화됩니다. \n 탈퇴하시겠습니까?", okText: "확인") {
            self.designateRootVC(OnbordingViewController())
            UserDefaults.standard.set(false, forKey: "isUser")
            UserDefaults.standard.set([], forKey: "userSearchWords")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
