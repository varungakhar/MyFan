//
//  ApiConstant.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

let KMainUrl = "https://myfan.com/api/v1/"
//let KMainUrl    =  "http://192.168.1.150:3000/api/v1/"
let KSignup  =   "register"
let KLogin    =  "login"
let KGetLoginData = "me"
let KUpdateIntrests = "register-steps-update"


let KProfessionalCategory =  "professional-category"
let KInterest =  "categories"
let KSignStepUpdate = "register-steps-update"

let KtopTrending = "landing/top-trending"
let Ktrendinglists = "landing/trending-lists"

let KtopRecent = "landing/top-recent"
let Krecentlists = "landing/recent-lists"

let KtopPopular = "landing/top-popular"
let Kpopularlists = "landing/popular-lists"

let KtopSpotlight = "landing/top-spotlight"
let Kspotlightlists = "landing/spotlight-lists"


let KfeedsTrending = "fan-feeds/trending"
let KfeedsRecent = "fan-feeds/recent"
let KfeedsSpotlight = "fan-feeds/spotlight"
let KfeedsPopular = "fan-feeds/popular"

let KfeedsUpvote = "/upvote"
let KfeedsDownvote = "/downvote"


let KSearchPost = "fan-feeds/search-posts"
let KSearchProfile = "fan-feeds/search-profiles"
let KSearchTags = "fan-feeds/search-tags"

let KtagPosts = "fan-feeds/tag-posts"
let KSuggetionTags = "posts/post-tags-suggestions"
let KUploadMultimedia = "upload"

let KSharePost = "posts"

// comments on post
let  KGetPostComments =   "/comments" //GET /posts/{id}/comments
let  KPostSendComments =   "comments"
let KCommentReply =         "/comment-reply"   //POST /comments/{slug}/comment-reply
let KCommentUpvote =         "/upvote"   //POST /comments/{slug}/upvote
let KCommentDownvote =         "/downvote" // POST /comments/{slug}/downvote
let KCommentDelete =         "/delete-comment" //DELETE /comments/{slug}/delete-comment

// my connections
let KMyRequests = "my-connections"
let KMyFans = "my-fans"
let KConnection_Suggestions = "connection-suggestions"
let KReceivedRequests = "received-requests"

let KNewConnectionRequest = "new-connection-request"
let KAcceptConnectionRequest = "accept-connection-request"
let KDeleteConnectionRequest = "delete-connection-request"
let KRemoveConnectedUser = "remove-connected-user"


// Music Section

let KGetNearByArtist = "music-feeds/near-artists"

let KMusicFeedsTrending = "music-feeds/trending"
let KMusicFeedsRecent = "music-feeds/recent"
let KMusicFeedsSpotlight = "music-feeds/spotlight"
let KMusicFeedsPopular = "music-feeds/popular"

let KMusicFeedsUploadNewSong = "music-feeds/upload-new-song"
let KMusicFeedsAlbumsLists = "music-feeds/albums-lists"

//Albums
let KGetAlbums = "albums"
let KAlbumSongs = "/albums_songs"

// PlayList

let KGetPlaylists = "playlists"
let KGetPlaylistSongs = "/playlists-songs"

// Genres

let KGetGenresList = "genres"
let KGetGenreSongs = "/genre-songs"


//My Assets
let KMy_Audios = "my-audios"
let KMy_Photos = "my-photos"
let KMy_Videos = "my-videos"

// Passion
let KBasePassion = "interests/"

let KPassionFollowing = "following"
let KPassionFollow = "follow-list"
let KPassionUnclassified = "unclassified"
let KPassionViewTopics = "/view-topics"
let KPassionSearchTopics = "search-topics"



