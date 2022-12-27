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
    
    let addCheckList = PublishSubject<String>()
    let editCheckList = PublishSubject<(String, Int)>()
    let removeCheckList = PublishSubject<Int>()
    let tapCheckBox = PublishSubject<(Bool, Int)>()
    
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
        let input = CheckListViewModel.Input(
            addCheckList: addCheckList.asObservable(),
            editCheckList: editCheckList.asObservable(),
            removeCheckList: removeCheckList.asObservable(),
            tapCheckBox: tapCheckBox.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        // 시간 설정 화면 띄우기
        timeView.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .subscribe(onNext: { [weak self] in
                self?.presentEditDateViewController()
            }).disposed(by: disposeBag)
        
        // TableView
        output.checkListItems
            .bind(to: tableView.rx.items(cellIdentifier: CheckListTableViewCell.identifier, cellType: CheckListTableViewCell.self)) { index, item, cell in
                cell.configure(item: item)
                cell.tapCheckBox
                    .map { ($0, index) }
                    .bind(to: self.tapCheckBox)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // 체크리스트 추가 버튼
        addCheckListButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showInputCheckListView(currentText: "", index: nil)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let str = output.checkListItems.value[indexPath.row].title
                self.showInputCheckListView(currentText: str, index: indexPath.row)
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
    
    private func showInputCheckListView(currentText: String, index: Int?) {
        let alert = InputCheckListViewController()
        alert.modalPresentationStyle = .overCurrentContext
        alert.currentText = currentText
        alert.addCheckList
            .subscribe(onNext: addCheckList.onNext)
            .disposed(by: disposeBag)
        
        alert.editCheckList
            .subscribe(onNext: { [weak self] str in
                self?.editCheckList.onNext((str, index!))
            })
            .disposed(by: disposeBag)
        
        alert.removeCheckList
            .subscribe(onNext: { [weak self] _ in self?.removeCheckList.onNext(index!) })
            .disposed(by: disposeBag)
        
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
