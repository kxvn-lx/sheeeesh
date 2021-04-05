//
//  Meme.swift
//  
//
//  Created by Kevin Laminto on 5/4/21.
//

import Foundation

// MARK: - MemeCollection
public struct MemeCollection: Codable, Hashable {
    public let code, count: Int
    public let memes: [Meme]
}

// MARK: - Meme
public struct Meme: Codable, Hashable {
    public let postLink: String
    public let subreddit, title: String
    public let url: String
    public let ups: Int
    public let author: String
    public let spoilersEnabled, nsfw: Bool
    public let imagePreviews: [String]
    
    public enum CodingKeys: String, CodingKey {
        case postLink = "post_link"
        case subreddit, title, url, ups, author
        case spoilersEnabled = "spoilers_enabled"
        case nsfw
        case imagePreviews = "image_previews"
    }
    
    public static let static_meme = Meme(
        postLink: "https://redd.it/mk0ns8",
        subreddit: "me_irl",
        title: "Me_irl",
        url: "https://i.imgur.com/6jFsSxI.jpg",
        ups: 41,
        author: "ohno__bees",
        spoilersEnabled: true,
        nsfw: false,
        imagePreviews: [
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=108&crop=smart&auto=webp&s=94a21c4000d9f28f958c60ad21353131012d5208",
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=216&crop=smart&auto=webp&s=cc76c54b269845f1281f5a9e124ed8ac1b509e62",
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=320&crop=smart&auto=webp&s=4bf4f830c47da1163ee1e9cd76cdc57c678834ea",
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=640&crop=smart&auto=webp&s=d08cfe46701f74a0c6989b1baecbb0077ffd00c7",
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=960&crop=smart&auto=webp&s=14cbd790c520a3ad439108a0d993065c9fd9236e",
            "https://external-preview.redd.it/3CtEn7AawS2_V02d23JO4a1Jgm_b1_jPf0-4rnBxs8k.jpg?width=1080&crop=smart&auto=webp&s=dece46f89bc302cb67bb1939f1e990dbd990748d"
        ])
}
