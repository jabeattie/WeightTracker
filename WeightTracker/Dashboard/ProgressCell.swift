//
//  ProgressCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit
import Charts

class ProgressCell: ResizableViewCell, NibLoadableView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var weightToLose: UILabel!
    @IBOutlet weak var targetWeight: UILabel!
    @IBOutlet weak var chart: PieChartView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 16
        setupChartView()
        setChartData()
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
        
        let centerText = NSMutableAttributedString(string: "4 lb, 4 oz\nWeightLost")
        centerText.addAttributes([.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light),
                                  .foregroundColor : UIColor.white.withAlphaComponent(0.5)], range: NSRange(location: centerText.length - 10, length: 10))
        centerText.addAttributes([.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
                                  .foregroundColor : UIColor.white], range: NSRange(location: 0, length: centerText.length - 10))
        chart.centerAttributedText = centerText
        
        chart.holeColor = UIColor.clear
        chart.drawHoleEnabled = true
        chart.rotationAngle = -90
        chart.rotationEnabled = false
        chart.highlightPerTapEnabled = false
        chart.legend.enabled = false
        chart.minOffset = 0
    }
    
    private func setChartData() {
        let entries = [PieChartDataEntry(value: 0.5, label: nil), PieChartDataEntry(value: 0.5, label: nil)]
        let dataSet = PieChartDataSet(values: entries, label: "Weight lost")
        dataSet.sliceSpace = 0
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor.white, UIColor.white.withAlphaComponent(0.25)]
        dataSet.selectionShift = 0
        
        let data = PieChartData(dataSet: dataSet)
        chart.data = data
    }

}
