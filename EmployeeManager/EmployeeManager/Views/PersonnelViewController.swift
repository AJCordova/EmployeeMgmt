//
//  PersonnelViewController.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/7/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PersonnelViewController: UIViewController {
    
    lazy var employerBannerLabel: UILabel = UILabel()
    lazy var tableView: UITableView = UITableView()
    lazy var addEmployeeButton: UIButton = UIButton()
    lazy var logoutButton: UIButton = UIButton()
    
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
        employerBannerLabel.text = viewModel.outputs.employer.name
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
            make.top.equalToSuperview().offset(80)
        }
    }
    
    private func setupEmployeeTableView() {
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(employerBannerLabel.snp.bottom).offset(50)
            make.width.equalToSuperview()
            make.height.equalTo(500)
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
    func setupBindings() {
        
        viewModel.outputs.employees.asObservable()
            .bind(to: tableView.rx.items) { (tableView, row, employee) -> UITableViewCell in
                let cell: EmployeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell") as! EmployeeTableViewCell
                
                cell.statusIndicator.backgroundColor = employee.isEmployed == true ? .systemGreen : .systemRed
                cell.nameLabel.text = employee.name
                cell.nameLabel.textColor = employee.isEmployed == true ? .black : .systemGray
                cell.selectionStyle = .none
                
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Employee.self)
            .subscribe(onNext: { employee in
                self.viewModel.inputs.editEmployee(employee: employee)
            })
            .disposed(by: disposeBag)
        
        addEmployeeButton.rx.tap
            .bind {
                self.viewModel.inputs.addEmployee()
            }
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .bind {
                print("logout tapped")
            }
            .disposed(by: disposeBag)
    }
}


