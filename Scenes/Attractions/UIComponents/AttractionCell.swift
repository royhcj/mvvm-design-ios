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
        
        let containerView: UIView = {
            let container = UIView()
            container.backgroundColor = .init(red: 1, green: 0.95, blue: 0.9, alpha: 1)
            container.layer.cornerRadius = 10
            container.layer.shadowRadius = 5
            container.layer.shadowColor = UIColor.black.cgColor
            container.layer.shadowOpacity = 0.3
            container.layer.masksToBounds = false
            contentView.addSubview(container)
            container.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(12)
            }
            return container
        }()
        
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.distribution = .equalSpacing
        containerView.addSubview(vstack)
        vstack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 10
        photoImageView.snp.makeConstraints {
            $0.height.equalTo(photoImageView.snp.width)
        }
        vstack.addArrangedSubview(photoImageView)
        
        vstack.addArrangedSubview({
            let spacing = UIView()
            spacing.snp.makeConstraints {
                $0.height.equalTo(15)
            }
            return spacing
        }())
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = .systemBlue
        vstack.addArrangedSubview(titleLabel)
        
        vstack.addArrangedSubview({
            let spacing = UIView()
            spacing.snp.makeConstraints {
                $0.height.equalTo(15)
            }
            return spacing
        }())
        
        vstack.addArrangedSubview({
            let divider = UIView()
            divider.backgroundColor = .systemBlue
            divider.snp.makeConstraints {
                $0.height.equalTo(1)
            }
            return divider
        }())
        
        vstack.addArrangedSubview({
            let spacing = UIView()
            spacing.snp.makeConstraints {
                $0.height.equalTo(15)
            }
            return spacing
        }())
        
        introductionLabel = UILabel()
        introductionLabel.font = UIFont.systemFont(ofSize: 14)
        introductionLabel.textColor = .darkGray
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
