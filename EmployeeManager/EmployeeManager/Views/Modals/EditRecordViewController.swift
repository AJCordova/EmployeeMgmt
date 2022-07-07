//
//  EditRecordViewController.swift
//  EmployeeManager
//
//  Created by COLLABERA on 7/8/22.
//

import Foundation
import UIKit
import RxSwift

class EditRecordViewController: UIViewController {
    
    lazy var cancelButton: UIButton = UIButton(type: .system) as UIButton
    lazy var saveButton: UIButton = UIButton()
    lazy var nameLabel: UILabel = UILabel()
    lazy var nameTextField: UITextField = UITextField()
    lazy var departmentLabel: UILabel = UILabel()
    lazy var departmentTextField: UITextView = UITextView()
    lazy var toggleStatusButton: UIButton = UIButton()
    lazy var deleteButton: UIButton = UIButton(type: .system) as UIButton
    
    var action: RecordEditAction = .add
    var employee: Employee?
    var service: RecordsServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    init(action: RecordEditAction, employee: Employee?, service: RecordsServiceProtocol) {
        self.action = action
        self.employee = employee
        self.service = service
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBindings()
        setEmployee(employee: employee)
    }
    
    private func setEmployee(employee: Employee?) {
        guard let employee = employee else { return }
        nameTextField.text = employee.name
        departmentTextField.text = employee.department
    }
}

extension EditRecordViewController {
    func setupViews() {
        setupCancelButton()
        setupSaveButton()
        setupNameLabel()
        setupNameTextField()
        setupDepartmentLabel()
        setupDepartmentTextField()
        setupToggleStatusButton()
        setupDeleteButton()
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .systemRed
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    private func setupDeleteButton() {
        deleteButton.setTitle("DELETE", for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.isHidden = action == .add ? true : false
        view.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    private func setupNameLabel() {
        nameLabel.text = "Employee Name: "
        nameLabel.font = .systemFont(ofSize: 20)
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(cancelButton.snp.bottom).offset(50)
        }
    }
    
    private func setupNameTextField() {
        nameTextField.layer.borderColor = UIColor.systemGray3.cgColor
        nameTextField.layer.borderWidth = 0.5
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(30)
        }
    }
    
    private func setupDepartmentLabel() {
        departmentLabel.text = "Department: "
        departmentLabel.font = .systemFont(ofSize: 20)
        view.addSubview(departmentLabel)
        
        departmentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
        }
    }
    
    private func setupDepartmentTextField() {
        departmentTextField.layer.borderColor = UIColor.systemGray3.cgColor
        departmentTextField.layer.borderWidth = 0.5
        departmentTextField.autocapitalizationType = .none
        departmentTextField.autocorrectionType = .no
        
        view.addSubview(departmentTextField)
        
        departmentTextField.snp.makeConstraints { make in
            make.top.equalTo(departmentLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(30)
        }
    }
    
    private func setupToggleStatusButton() {
        toggleStatusButton.setTitle(employee?.isEmployed == true ? "Resign Employee" : "Activate Employee", for: .normal)
        toggleStatusButton.setTitleColor(.systemBlue, for: .normal)
        toggleStatusButton.isHidden = action == .add
        view.addSubview(toggleStatusButton)
        
        toggleStatusButton.snp.makeConstraints { make in
            make.top.equalTo(departmentTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func setupSaveButton() {
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 9.0
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
}

extension EditRecordViewController {
    func setupBindings() {
        let shouldShowSaveButton = self.nameTextField.rx.text.orEmpty
            .map { $0.count < 3 }
            .asObservable()
        
        shouldShowSaveButton.asObservable()
            .bind(to: saveButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind {
                guard let name = self.nameTextField.text else { return }

                switch self.action {
                case .add:
                    self.service.add(employee: Employee(name: name,
                                                   isEmployed: true,
                                                   department: self.departmentTextField.text ?? ""))
        
                    self.dismiss(animated: true)
                case .edit:
                    guard var employee = self.employee else { return }
                    employee.name = name
                    employee.department = self.departmentTextField.text ?? ""
                    self.service.edit(employee: employee)
                }
                
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        toggleStatusButton.rx.tap
            .bind {
                guard var employee = self.employee else { return }
                employee.isEmployed.toggle()
                
                guard let name = self.nameTextField.text else { return }
                employee.name = name
                employee.department = self.departmentTextField.text ?? ""
                self.service.edit(employee: employee)
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        deleteButton.rx.tap
            .bind {
                guard let employee = self.employee else { return }
                self.service.delete(employee: employee)
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind {
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
