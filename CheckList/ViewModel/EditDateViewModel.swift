//
//  EditDateViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import Foundation
import RxSwift
import RxCocoa

class EditDateViewModel: ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    let tableViewItems: BehaviorRelay<[Day]> = BehaviorRelay(value: [
        Day(title: "일", isSelected: false),
        Day(title: "월", isSelected: false),
        Day(title: "화", isSelected: false),
        Day(title: "수", isSelected: false),
        Day(title: "목", isSelected: false),
        Day(title: "금", isSelected: false),
        Day(title: "토", isSelected: false)
    ])
    
    struct Input {
        let tapSaveButton: Observable<Void>
        let changeDate: Observable<Date>
        let changeDay: Observable<Int>
    }
    
    struct Output {
        let selectedDate: Observable<Alarm>
    }
    
    func transform(input: Input) -> Output {
        let selectedDate = Observable
            .combineLatest(input.tapSaveButton, input.changeDate, input.changeDay)
            .map { [weak self] (_, date, day) -> Alarm in
                guard let self = self else { return Alarm(time: "", day: []) }
                let selectedTime = self.convertDateToString(date)
                let seletedDay = self.tableViewItems.value
                    .filter { $0.isSelected }
                    .map { $0.title }
                
                let selectedDate = Alarm(time: selectedTime, day: seletedDay)
                
                return selectedDate
            }
        
        input.changeDay
            .subscribe(onNext: { [weak self] index in
                var items = self?.tableViewItems.value
                items![index].isSelected.toggle()
                self?.tableViewItems.accept(items!)
            })
            .disposed(by: disposeBag)
            
        
        return Output(selectedDate: selectedDate)
    }
    
    func convertDateToString(_ date: Date) -> String {
        let dateFomatter = DateFormatter()
        dateFomatter.timeZone = .autoupdatingCurrent
        dateFomatter.locale = Locale(identifier: "ko_KR")
        dateFomatter.dateFormat = "HH:mm"
        
        return dateFomatter.string(from: date)
    }
}
