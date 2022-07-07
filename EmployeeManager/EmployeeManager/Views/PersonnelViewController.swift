//
//  PersonnelRecordViewController.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import UIKit
import RxSwift

class PersonnelViewController: UIViewController {
    
    lazy var employerBannerLabel: UILabel = UILabel()
    lazy var logoutButton: UIButton = UIButton()
    lazy var tableView: UITableView = UITableView()
    lazy var addEmployeeButton: UIButton = UIButton()
    
    private let disposeBag = DisposeBag()
    private var viewModel: PersonnelViewModelTypes
    
    init(viewModel: PersonnelViewModelTypes) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

extension PersonnelViewController {
    func setupViews() {
        setupEmployerBannerLabel()
        setupLogoutButton()
        setupEmployeeTableView()
        setupAddEmployeeButton()
    }
    
    private func setupEmployerBannerLabel() {
        employerBannerLabel.font = .systemFont(ofSize: 30, weight: .bold)
        view.addSubview(employerBannerLabel)

        employerBannerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
    }
    
    private func setupLogoutButton() {
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 9.0
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(25)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(60)
        }
    }
    
    private func setupEmployeeTableView() {
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.backgroundColor = .systemYellow
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(employerBannerLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(580)
        }
    }
    
    private func setupAddEmployeeButton() {
        addEmployeeButton.backgroundColor = .systemGreen
        addEmployeeButton.setTitle("Add Employee", for: .normal)
        addEmployeeButton.layer.cornerRadius = 9.0
        view.addSubview(addEmployeeButton)
        
        addEmployeeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}

extension PersonnelViewController {
    func setupBindings() {}
}




