//
//  ProgressCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit
import Charts

class ProgressCellViewModel {
    private let decorator: WeightDecorator
    private let calculator: ProgressCalculator
    private let user: User?
    private var cachedProgress: ProgressCalculator.WeightProgess?
    
    init(user: User?, calculator: ProgressCalculator, decorator: WeightDecorator) {
        self.calculator = calculator
        self.decorator = decorator
        self.user = user
        guard let target = user?.targetWeight, let current = user?.currentWeight else { return }
        self.cachedProgress = calculator.calculate(targetWeight: target, currentWeight: current)
    }
    
    var progress: (Double, Double) {
        guard let progress = cachedProgress else { return (0.0, 0.0) }
        let complete = progress.progress
        let toGo = 1 - complete
        return (complete, toGo)
    }
    
    var changeData: (String, String) {
        return (change ?? "", subtitle ?? "")
    }
    
    private var subtitle: String? {
        guard let targetWeight = user?.targetWeight else { return nil }
        return targetWeight.targetType.displayValue
    }
    
    private var change: String? {
        guard let progress = cachedProgress else { return nil }
        return decorator.displayValue(for: progress.delta)
    }
    
    var remaining: String? {
        guard let progress = cachedProgress else { return nil }
        return decorator.displayValue(for: progress.remaining)
    }
    
    var target: String? {
        guard let target = user?.targetWeight?.target else { return nil }
        return decorator.displayValue(for: target)
    }
}

class ProgressCell: ResizableViewCell, NibLoadableView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var weightToLose: UILabel!
    @IBOutlet weak var targetWeight: UILabel!
    @IBOutlet weak var chart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 16
        setupChartView()
        setChart()
    }
    
    private func setupChartView() {
        chart.usePercentValuesEnabled = false
        chart.drawSlicesUnderHoleEnabled = false
        chart.holeRadiusPercent = 0.94
        chart.transparentCircleRadiusPercent = 0.94
        chart.chartDescription?.enabled = false
        
        chart.drawCenterTextEnabled = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        setCenter()
        
        chart.holeColor = UIColor.clear
        chart.drawHoleEnabled = true
        chart.rotationAngle = -90
        chart.rotationEnabled = false
        chart.highlightPerTapEnabled = false
        chart.legend.enabled = false
        chart.minOffset = 0
    }
    
    private func setChart(data: (Double, Double) = (0, 100)) {
        let entries = [PieChartDataEntry(value: data.0, label: nil), PieChartDataEntry(value: data.1, label: nil)]
        let dataSet = PieChartDataSet(values: entries, label: "Weight lost")
        dataSet.sliceSpace = 0
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor.white, UIColor.white.withAlphaComponent(0.25)]
        dataSet.selectionShift = 0
        
        let data = PieChartData(dataSet: dataSet)
        chart.data = data
    }
    
    private func setCenter(text: (String, String) = ("", "")) {
        let centerText = NSMutableAttributedString(string: "\(text.0)\n\(text.1)")
        let adjustedCenter = centerText.length - text.1.count
        centerText.addAttributes([.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
                                  .foregroundColor: UIColor.white], range: NSRange(location: 0, length: adjustedCenter))
        centerText.addAttributes([.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light),
                                  .foregroundColor: UIColor.white.withAlphaComponent(0.5)], range: NSRange(location: adjustedCenter, length: text.1.count))
        chart.centerAttributedText = centerText
    }
    
    
    func update(_ viewModel: ProgressCellViewModel) {
        weightToLose.text = viewModel.remaining
        targetWeight.text = viewModel.target
        setChart(data: viewModel.progress)
        setCenter(text: viewModel.changeData)
    }

}
