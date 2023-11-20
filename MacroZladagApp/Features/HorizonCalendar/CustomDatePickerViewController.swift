//
//  CustomDatePickerViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/11/23.
//

import UIKit
import HorizonCalendar
protocol CustomDatePickerViewControllerDelegate {
    func getDateLabel()
}
class CustomDatePickerViewController: UIViewController {

    var delegate: CustomDatePickerViewControllerDelegate?
    var mainView: MainHeaderCollectionReusableView?
    var controllerDelegate: SearchResultsViewController?
    var ubahControllerDelegate: UbahPencarianViewController?
    
    var todayComps: DateComponents? = Calendar.current.dateComponents(in: .current, from: Date())
    
    var calendarView: CalendarView?
    var selectedDay1: Day? = AppAccountManager.shared.selectedDay1
    var selectedDay2: Day? = AppAccountManager.shared.selectedDay2
    
    let dariTanggalLabel = UILabel()
    let minDateLabel = UILabel()
    
    let sampaiTanggalLabel = UILabel()
    let maxDateLabel = UILabel()
    
    let simpanButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        
        setupNavBar()
        setupCalendar()
        setupLabels()
        setupSimpanButton()
    }
    
    
    func doTheLogic(_ day: Day) {
        if self.selectedDay1 == nil && self.selectedDay2 == nil {
            if day.components.day! >= todayComps!.day! {
                self.selectedDay1 = day
            } else {
                if day.components.month! > todayComps!.month! {
                    self.selectedDay1 = day
                } else {
                    self.selectedDay1 = nil
                }
            }
        } else if self.selectedDay1 != nil && self.selectedDay2 == nil {
            if day.components.day! >= todayComps!.day! {
                self.selectedDay2 = day
            } else {
                if day.components.month! > todayComps!.month! {
                    self.selectedDay2 = day
                } else {
                    self.selectedDay1 = nil
                    self.selectedDay2 = nil
                }
            }
            
            if self.selectedDay2 != nil {
                if self.selectedDay2! <= self.selectedDay1! {
                    self.selectedDay1 = day
                    self.selectedDay2 = nil
                }
            }
        } else if self.selectedDay1 != nil && self.selectedDay2 != nil {
            self.selectedDay1 = day
            self.selectedDay2 = nil
            
            if day.components.day! >= todayComps!.day! {
                self.selectedDay1 = day
            } else {
                if day.components.month! > todayComps!.month! {
                    self.selectedDay1 = day
                } else {
                    self.selectedDay1 = nil
                }
            }
        }
        
        updateDateLabel(day1: self.selectedDay1, day2: self.selectedDay2)
    }
    
    func updateDateLabel(day1: Day?, day2: Day?) {
        
        if day1 == nil {
            minDateLabel.text = "-"
        } else {
            minDateLabel.text = Utils.getFormattedDate(date: Calendar.current.date(from: day1!.components)!)
        }
        
        if day2 == nil {
            maxDateLabel.text = "-"
        } else {
            maxDateLabel.text = Utils.getFormattedDate(date: Calendar.current.date(from: day2!.components)!)
        }
    }
    
    func setupCalendar() {
        calendarView = CalendarView(initialContent: makeContent()) // HORIZON CALENDAR'S
        guard let calendarView else { return }
        
        calendarView.backgroundColor = .white
        
        view.addSubview(calendarView)
        
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            self.doTheLogic(day)

            let newContent = self.makeContent()
            self.calendarView?.setContent(newContent)
            print("1", self.selectedDay1)
            print("2", self.selectedDay2)
            print("")
        }

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 21.5),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.widthAnchor.constraint(equalToConstant: 342),
            calendarView.heightAnchor.constraint(equalToConstant: 358 - 35)
        ])
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current

        let startDate = calendar.date(from: DateComponents(year: 2023, month: 11, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!

        var dateRangeToHighlight = Date.now...Date.now
        
        
        if self.selectedDay1 != nil && self.selectedDay2 != nil {
            let lowerDate = calendar.date(from: self.selectedDay1!.components)!
            let upperDate = calendar.date(from: self.selectedDay2!.components)!
            dateRangeToHighlight = lowerDate...upperDate
        } else {
            dateRangeToHighlight = Date.now...Date.now
        }
        
//        let selectedDay1 = self.selectedDay1
//        let selectedDay2 = self.selectedDay2
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions())
        )
            .interMonthSpacing(24)
            .verticalDayMargin(10)
            .horizontalDayMargin(10)
            .dayItemProvider { day in
                
                var invariantViewProperties = DayLabel.InvariantViewProperties.init(
                    font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                    textColor: .textBlack,
                    backgroundColor: .clear
                )
                
                if let todayComps = self.todayComps {
                    if
                        let dayTemp = day.components.day,
                        let monthTemp = day.components.month,
                        let yearTemp = day.components.year
                    {
                        if dayTemp == todayComps.day && monthTemp == todayComps.month && yearTemp == todayComps.year {
                            invariantViewProperties.textColor = .textBlack
                            invariantViewProperties.backgroundColor = .customLightGray.withAlphaComponent(0.2)
                        }
                    }
                }
                
                if day == self.selectedDay1 {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = .customOrange
                }
                
                if day == self.selectedDay2 {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = .customOrange
                }
                
                
                return DayLabel.calendarItemModel(
                    invariantViewProperties: invariantViewProperties,
                    viewModel: DayLabel.ViewModel.init(day: day)
                )
            }
            .dayRangeItemProvider(for: [dateRangeToHighlight]) { dayRangeLayoutContext in
                if self.selectedDay1 != nil && self.selectedDay2 != nil {
//                    self.todayComps = nil
                    return DayRangeIndicatorView.calendarItemModel(
                        invariantViewProperties: DayRangeIndicatorView.InvariantViewProperties.init(indicatorColor: .orangeDateRange),
                        viewModel: DayRangeIndicatorView.ViewModel.init(framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame })
                    )
                } else {
//                    self.todayComps = Calendar.current.dateComponents(in: .current, from: Date())
                    return DayRangeIndicatorView.calendarItemModel(
                        invariantViewProperties: DayRangeIndicatorView.InvariantViewProperties.init(indicatorColor: UIColor.black),
                        viewModel: DayRangeIndicatorView.ViewModel.init(framesOfDaysToHighlight: [CGRect.zero])
                    )
                }
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLabels()
    }
    
    func setupLabels() {
        view.addSubview(dariTanggalLabel)
        view.addSubview(sampaiTanggalLabel)
        view.addSubview(minDateLabel)
        view.addSubview(maxDateLabel)
        
        guard let calendarView else { return }
        
        dariTanggalLabel.text = "Dari tanggal"
        dariTanggalLabel.font = .systemFont(ofSize: 13, weight: .medium)
        dariTanggalLabel.textColor = .textBlack
        dariTanggalLabel.sizeToFit()
        
        sampaiTanggalLabel.text = "Sampai tanggal"
        sampaiTanggalLabel.font = .systemFont(ofSize: 13, weight: .medium)
        sampaiTanggalLabel.textColor = .textBlack
        sampaiTanggalLabel.sizeToFit()
        
        if AppAccountManager.shared.selectedDay1 == nil {
            minDateLabel.text = "-"
        } else {
            minDateLabel.text = "\(Utils.getFormattedDate(date: Calendar.current.date(from: selectedDay1!.components)!))"
        }
        minDateLabel.font = .systemFont(ofSize: 16, weight: .bold)
        minDateLabel.textColor = .textBlack
        minDateLabel.textAlignment = .left
        minDateLabel.sizeToFit()
        
        if AppAccountManager.shared.selectedDay1 == nil {
            maxDateLabel.text = "-"
        } else {
            maxDateLabel.text = "\(Utils.getFormattedDate(date: Calendar.current.date(from: selectedDay2!.components)!))"
        }
        maxDateLabel.font = .systemFont(ofSize: 16, weight: .bold)
        maxDateLabel.textColor = .textBlack
        maxDateLabel.textAlignment = .right
        maxDateLabel.sizeToFit()
        
        dariTanggalLabel.translatesAutoresizingMaskIntoConstraints = false
        minDateLabel.translatesAutoresizingMaskIntoConstraints = false
        sampaiTanggalLabel.translatesAutoresizingMaskIntoConstraints = false
        maxDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dariTanggalLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 24),
            dariTanggalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            dariTanggalLabel.widthAnchor.constraint(equalToConstant: dariTanggalLabel.width),
            dariTanggalLabel.heightAnchor.constraint(equalToConstant: dariTanggalLabel.height),
            
            minDateLabel.topAnchor.constraint(equalTo: dariTanggalLabel.bottomAnchor),
            minDateLabel.leadingAnchor.constraint(equalTo: dariTanggalLabel.leadingAnchor),
            minDateLabel.widthAnchor.constraint(equalToConstant: 165),
            minDateLabel.heightAnchor.constraint(equalToConstant: minDateLabel.height),
            
            sampaiTanggalLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 24),
            sampaiTanggalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sampaiTanggalLabel.widthAnchor.constraint(equalToConstant: sampaiTanggalLabel.width),
            sampaiTanggalLabel.heightAnchor.constraint(equalToConstant: sampaiTanggalLabel.height),
            
            maxDateLabel.topAnchor.constraint(equalTo: sampaiTanggalLabel.bottomAnchor),
            maxDateLabel.trailingAnchor.constraint(equalTo: sampaiTanggalLabel.trailingAnchor),
            maxDateLabel.widthAnchor.constraint(equalToConstant: 165),
            maxDateLabel.heightAnchor.constraint(equalToConstant: maxDateLabel.height),
        ])
    }
    
    func setupSimpanButton() {
        view.addSubview(simpanButton)
        
        simpanButton.backgroundColor = .customOrange
        simpanButton.layer.cornerRadius = 4
        simpanButton.layer.masksToBounds = true
        
        simpanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            simpanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simpanButton.topAnchor.constraint(equalTo: maxDateLabel.bottomAnchor, constant: 24),
            simpanButton.widthAnchor.constraint(equalToConstant: 342),
            simpanButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        let label = UILabel()
        label.text = "Simpan"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.sizeToFit()
        simpanButton.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: simpanButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: simpanButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        simpanButton.addTarget(self, action: #selector(onClickSimpanButton), for: .touchUpInside)
    }
    
    func setupNavBar() {
        let navBarView = UIView()
        navBarView.backgroundColor = .white
        navBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        
        let title = UILabel()
        navBarView.addSubview(title)
        title.text = "Pilih Tanggal Penitipan"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .textBlack
        title.sizeToFit()
        title.frame = CGRect(x: -2, y: 16, width: title.width, height: title.height)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "sheet-close-button"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(
            x: navBarView.frame.maxX - 60,
            y: 10,
            width: 32,
            height: 32
        )
        navBarView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(onClickCloseButton), for: .touchUpInside)
        
        navigationItem.titleView = navBarView
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc func onClickSimpanButton() {
        print("simpan")
        guard self.selectedDay1 != nil && self.selectedDay2 != nil else { return }
        
        let date1 = Calendar.current.date(from: self.selectedDay1!.components)!
        let date1String = Utils.getFormattedDateShorted(date: date1)
        
        let date2 = Calendar.current.date(from: self.selectedDay2!.components)!
        let date2String = Utils.getFormattedDateShortedWithYear(date: date2)
        
        self.mainView?.minDate = date1
        self.mainView?.maxDate = date2
        self.mainView?.dateFieldView.thisLabel.text = "\(date1String) - \(date2String)"
        
        self.ubahControllerDelegate?.dateFieldView.thisLabel.text = "\(date1String) - \(date2String)"
                
        AppAccountManager.shared.calendarTextDetails = "\(date1String) - \(date2String)"
        AppAccountManager.shared.selectedDay1 = self.selectedDay1
        AppAccountManager.shared.selectedDay2 = self.selectedDay2
        
//        print(self.mainView?.minDate) // MARK: CATATAN
//        print(self.mainView?.maxDate)
        delegate?.getDateLabel()
        dismiss(animated: true)
    }
    
    @objc func onClickCloseButton() {
        dismiss(animated: true)
    }
    

}
