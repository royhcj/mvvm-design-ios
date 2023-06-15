//
//  AttractionCell.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import UIKit
import Domain
import SnapKit
import Kingfisher

public class AttractionCell: UITableViewCell {
    
    public static let cellIdentifier: String = "AttractionCell"
    
    private var photoImageView: UIImageView!
    @objc private var titleLabel: UILabel!
    @objc private var introductionLabel: UILabel!
    
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
        contentView.backgroundColor = .white
        
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.distribution = .equalSpacing
        contentView.addSubview(vstack)
        vstack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
        }
        
        photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.snp.makeConstraints {
            $0.height.equalTo(photoImageView.snp.width)
        }
        vstack.addArrangedSubview(photoImageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        vstack.addArrangedSubview(titleLabel)
        
        vstack.addArrangedSubview({
            let divider = UIView()
            divider.backgroundColor = .gray
            divider.snp.makeConstraints {
                $0.height.equalTo(1)
            }
            return divider
        }())
        
        introductionLabel = UILabel()
        introductionLabel.font = UIFont.systemFont(ofSize: 13)
        introductionLabel.numberOfLines = 2
        vstack.addArrangedSubview(introductionLabel)
    }
    
    // MARK: - Configuring
    public func configure(with attraction: Attraction) {
        photoImageView.kf.setImage(with: attraction.images.first?.url)
        titleLabel.text = attraction.name
        introductionLabel.text = attraction.introduction
    }
}
