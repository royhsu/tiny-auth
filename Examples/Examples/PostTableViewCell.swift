//
//  PostTableViewCell.swift
//  Examples
//
//  Created by Roy Hsu on 2019/8/22.
//

// MARK: - PostTableViewCell

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private(set) lazy var contentLabel: UILabel = {
        
        let contentLabel = UILabel()
        
        contentLabel.numberOfLines = 0
        
        contentLabel.adjustsFontForContentSizeCategory = true
        
        contentLabel.font = .preferredFont(
            forTextStyle: .body,
            compatibleWith: traitCollection
        )
        
        return contentLabel
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        load()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        load()
        
    }
    
}

extension PostTableViewCell {
    
    private func load() {
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate(
            [
                contentView.readableContentGuide.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
                contentView.readableContentGuide.topAnchor.constraint(equalTo: contentLabel.topAnchor),
                contentView.readableContentGuide.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
                contentView.readableContentGuide.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor),
            ]
        )
        
    }
    
}

