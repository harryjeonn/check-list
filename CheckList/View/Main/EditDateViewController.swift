//
//  EditDateViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import UIKit
import RxSwift
import RxCocoa

class EditDateViewController: UIViewController {
    let viewModel: EditDateViewModel
    var disposeBag = DisposeBag()
    
    let seletedDate = PublishSubject<Alarm>()
    
    init(viewModel: EditDateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = EditDateViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
        configureTableView()
        bind()
    }
    
    private func bind() {
        let input = EditDateViewModel.Input(
            tapSaveButton: topBarView.rightButton.rx.tap.map { _ in () },
            changeDate: datePicker.rx.date.asObservable(),
            changeDay: tableView.rx.itemSelected.map { $0.row }.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.selectedDate
            .do(onNext: seletedDate.onNext)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        topBarView.leftButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.tableViewItems
            .bind(to: tableView.rx.items(cellIdentifier: DayPickerTableViewCell.identifier, cellType: DayPickerTableViewCell.self)) { index, item, cell in
                cell.configureCell(item)
            }
            .disposed(by: disposeBag)
    }
    
    func configureTableView() {
        tableView.register(DayPickerTableViewCell.self, forCellReuseIdentifier: DayPickerTableViewCell.identifier)
    }
    
    // MARK: - View
    let topBarView: TopBarView = {
        let view = TopBarView()
        view.titleLabel.text = "알람 설정"
        view.leftButton.setTitle("이전", for: .normal)
        view.rightButton.setTitle("저장", for: .normal)
        
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = .autoupdatingCurrent
        
        return datePicker
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        
        return view
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        self.view.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom).offset(28)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(150)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(28)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
        }
    }
}
