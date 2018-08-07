//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit


enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case TQLogin = 0,
    TQSignup,
    TQForgetPassword ,
    TQSkip
}

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""


var DEVICE_ENDLAT =  31.504486
var DEVICE_ENDLONG = 74.331563



let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL

let BASE_URL  =  "http://85.214.88.81/restapi/"


let BASE_URLFORTHECONTESTANTImage  =  "http://adadigbomma.com/panel/images/contestant/"
let BASE_URLFOR_GALLERY_Image  =  "http://adadigbomma.com/panel/images/gallery/"
let BASE_URLFOR_NEWImage  =  "http://adadigbomma.com/panel/images/"



//let BASE_URL  =  "http://adadigbomma.com/"

//LOCAL URL
//let BASE_URL = "http://192.168.1.192/whereapp/api/"


//let API_KEY = "jIbF3yQG0s/AliunDtw3yYfH5w1mzOk5MaTeXIU5ORI="

//service URLS
let VERIFY_CODE = BASE_URL + "user/verify"
//let SIGNUP = BASE_URL + "user/register"

let SIGNUP = BASE_URL + "user/register"

// MF Project

let COLLECTION = BASE_URL + "collection"
let USERFavourite = BASE_URL + "userFavorites"
let MONTHCOLLECTION = BASE_URL + "collectionByMonth"
let WEEKCOLLECTION = BASE_URL + "collectionByWeek"

let ALLCOLLECTIONTRADE = BASE_URL + "collectionTrending"
let SIGNUPSOCIAL = BASE_URL + "signup"
let USERLIKEORDISLIKE = BASE_URL + "userliked"
let COLLECTIONPRODUCT = BASE_URL + "collectionProducts"







let UPDATE_PROFILE_PIC = BASE_URL + "user/update-avatar"
let PROFILENOTARY = BASE_URL + "notary/profile"
let GETNOTARIFYPROFILE = BASE_URL + "notary/profile"
let PROFILENOTARYUpdate = BASE_URL + "notary/profile/2"
let GETSERVICE_LIST = BASE_URL + "notary/services"
let GETCLientREQUEST = BASE_URL + "client/request"


let GETALLREVIEWLIST = BASE_URL + "notary/reviews"
let GETALLCertificate = BASE_URL + "notary/certificates"

let UPDATE_CERTIFICATE = BASE_URL + "notary/certificates"

let GETNOTARY_LIST = BASE_URL + "client/search"

let CLIENT_REQUEST = BASE_URL + "client/request"




let VERIFICATION_CODE = BASE_URL + "phoneVerification"
let LOGIN = BASE_URL + "user/login"
let BookAPPOINTMENT = BASE_URL + "bookAppointment"
//let SIGNUP = BASE_URL + "register"
let FORGET_PASSWORD = BASE_URL + "forgotPassword"
let BROWSE_POST = BASE_URL + "browse"
let AUDITION_API = BASE_URL + "App/audition"
let GETALLCategories = BASE_URL + "categories"
let GETSUBCategorie = BASE_URL + "sub_categories"
let GETALLSHOP = BASE_URL + "getallshopsbysubcategoryid"
let FAVOURITE_SALOON = BASE_URL + "favorite_saloon"
let GETSHOP_DETAIL = BASE_URL + "shop_details"
let GETUSER_PROFILE = BASE_URL + "profile"
let GETSHOP_PRODUCT = BASE_URL + "getShopProductsbyShopId"
let GETSTAF_SHOP = BASE_URL + "getStaffbyShopId"
let GETFAV_SHOP = BASE_URL + "userFavoriteShops"




let GETSHOP_APPOINTMENT = BASE_URL + "getIosAppointmentsByShopId"
//let GETUSER_APPOINTMENT = BASE_URL + "userAppointments"



let GET_APPOINTMENT = BASE_URL + "userAppointments"





let GETContestantDetail = BASE_URL + "App/getDetail"
let GETContestTantVideos = BASE_URL + "App/getvideos"
let FORGOT_Password = BASE_URL + "user/forgot-password"
let CODE_SEND = BASE_URL + "verifycode"
let RESET_PASSWORD = BASE_URL + "user/change-password"
let CHANGE_PASSPRofile = BASE_URL + "user/change-known-password"




let GETContestTantPhotos = BASE_URL + "App/getphotos"
let GETMediaPhotosAndVideo = BASE_URL + "App/getmedia"
let GETVote = BASE_URL + "App/vote"
let PULLTHEVOTE = BASE_URL + "App/voteher"

let GETSOcial = BASE_URL + "App/getsocial"
let SOCIAL_LOGIN = BASE_URL + "sociallogin"
let ADIM_NEWS   = BASE_URL + "App/news"
let ADIM_TEAM   = BASE_URL + "App/team"
let ADIM_TV   = BASE_URL + "App/adimtv"




let VIDEO_SEEN = BASE_URL + "post_seen"
let NEW_POST = BASE_URL + "new_post"
let RESPOND_POST = BASE_URL + "respondPost"
let PROFILE = BASE_URL + "getProfile"
let MY_POSTS_RESPONSE = BASE_URL + "myPosts"
let UPDATE_PROFILE = BASE_URL + "updateProfile"
let UPDATE_PASSWORD = BASE_URL + "updatePassword"
let SAVE_PURCHASE = BASE_URL + "savePurchase"
let POST_HANDSHAKE = BASE_URL + "postHandShake"
let GET_CAT = BASE_URL + "getCategories"
let GET_USER_BUSINESS = BASE_URL + "getUserBusiness"
let ADD_NEW_BUSINESS = BASE_URL + "addNewBusiness"
let EDIT_USER_BUSINESS = BASE_URL + "editUserBusiness"
let ADD_SCHEDULE = BASE_URL + "addNewSchedule"
let GET_PROFILE = BASE_URL + "getProfile"
let EDIT_SCHEDULE = BASE_URL + "editSchedule"
let POST_COMMENT = BASE_URL + "postComment"
let GET_COMMENTS = BASE_URL + "getBusinessComments"
let DELETE_SCHEDULE = BASE_URL + "deleteSchedule"
let ENABLE_SCHEDULE = BASE_URL + "enableSchedule"
let UPLOAD_GALLERY = BASE_URL + "uploadGallery"
let DELETE_GALLERY = BASE_URL + "deleteGallery"
let RESETCODE = BASE_URL + "checkResetCode"
let Logout = BASE_URL  + "logout"
let ChnagePassword  = BASE_URL + "changePassword"



//var localUserData: UserData!
//var notificationType = "none"

//var localUserData: UserInformation!


let kUserNameRequiredLength: Int = 4
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 6
let KValidationPassword : String = "Password must be greater 6 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kUpdateTokenMessage: String = "user does not exists"
let KMessageTitle: String = "MobinP"

