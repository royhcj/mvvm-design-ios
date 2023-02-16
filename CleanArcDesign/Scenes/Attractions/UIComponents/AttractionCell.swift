//
//  AttractionCell.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import UIKit
import SnapKit

public class AttractionCell: UITableViewCell {
    
    public static let cellIdentifier: String = "AttractionCell"
    
    private var titleLabel: UILabel!
    private var introductionLabel: UILabel!
    
    // MARK: - Object lifecycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createLayout()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
    }
    
    private func createLayout() {
        contentView.backgroundColor = .gray
        
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.distribution = .equalSpacing
        contentView.addSubview(vstack)
        vstack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        vstack.addArrangedSubview(titleLabel)
        
        introductionLabel = UILabel()
        introductionLabel.font = UIFont.systemFont(ofSize: 13)
        introductionLabel.numberOfLines = 2
        vstack.addArrangedSubview(introductionLabel)
    }
    
    // MARK: - Configuring
    public func configure(with attraction: Attraction) {
        titleLabel.text = attraction.name
        introductionLabel.text = attraction.introduction
    }
}
