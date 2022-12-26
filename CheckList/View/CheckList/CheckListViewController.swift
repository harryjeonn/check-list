//
//  CheckListViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController

class CheckListViewController: UIViewController {
    let viewModel: CheckListViewModel
    var disposeBag = DisposeBag()
    
    init(viewModel: CheckListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = CheckListViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bind()
    }
    
    private func bind() {
        let input = CheckListViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        // 시간 설정 화면 띄우기
        timeView.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .subscribe(onNext: { [weak self] in
                self?.presentEditDateViewController()
            }).disposed(by: disposeBag)
        
        // TableView
        viewModel.checkListItems
            .bind(to: tableView.rx.items(cellIdentifier: CheckListTableViewCell.identifier, cellType: CheckListTableViewCell.self)) { index, item, cell in
                cell.titleLabel.text = item
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        // 체크리스트 추가 버튼
        addCheckListButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showInputCheckListView()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentEditDateViewController() {
        let vc = EditDateViewController(viewModel: EditDateViewModel())
        vc.seletedDate.subscribe(onNext: { [weak self] alarm in
            self?.timeView.timeText.text = alarm.time
            self?.timeView.dayText.text = alarm.day.joined(separator: ", ")
        })
        .disposed(by: disposeBag)
        self.present(vc, animated: true)
    }
    
    private func showInputCheckListView() {
        let alert = InputCheckListViewController()
        alert.modalPresentationStyle = .overCurrentContext
        self.present(alert, animated: false)
    }
    
    // MARK: - View
    let topBarView: TopBarView = {
        let view = TopBarView()
        view.titleLabel.text = "제목"
        view.leftButton.setTitle("이전", for: .normal)
        view.rightButton.setTitle("저장", for: .normal)
        
        return view
    }()
    
    private let timeView: TimeView = {
        let view = TimeView()
        view.backgroundColor = .white
        view.setRadiusAndShadow()
        
        return view
    }()
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        
        return view
    }()
    
    private let addCheckListButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("+ 항목을 추가해주세요!", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.contentHorizontalAlignment = .leading
        btn.setRadiusAndShadow()
        
        return btn
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom).offset(12)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(80)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(24)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        tableView.register(CheckListTableViewCell.self, forCellReuseIdentifier: CheckListTableViewCell.identifier)
        tableView.rowHeight = 62 // 셀 간격 12를 계산하여 50 + 12로 설정
        
        view.addSubview(addCheckListButton)
        addCheckListButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(24)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            make.height.equalTo(50)
        }
    }
}
