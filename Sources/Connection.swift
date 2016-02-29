import Foundation

let developmentServerURL = NSURL(string: "https://api.development.push.apple.com:443")!
let productionServerURL = NSURL(string: "https://api.push.apple.com:443")!

/// Abstraction for initiating an interaction with APNs.
struct Provider {
    /// Server endpoint configuartion for APNs.
    enum Server {
        case Development
        case Production

        var URL: NSURL {
            switch self {
            case .Development:
                return developmentServerURL
            case .Production:
                return productionServerURL
            }
        }
    }

    /// Server of which to connect.
    let server: Server

    /// Identifying certificate for connecting to server.
    let certificate: NSData

    init(server: Server, certificate: NSData) {
        self.server = server
        self.certificate = certificate
    }

    // TODO
    /// Opens connection to provider.
    /// returns: Connection to the APNs provider
    func connect() -> Connection {
        return Connection()
    }

    /// Closes a connection to provider
    func disconect(connection: Connection) {
        // TODO
    }
}

struct Connection {
    func sendRequest(request: Request, completion: (Response -> Void)) {

    }
}

protocol Request {
    var method: String { get }
    var path: String { get }
    var headers: [String:AnyObject] { get }
}

struct SendNotificationRequest: Request {
    let method = "POST"
    let path: String
    let headers: [String:AnyObject]

    init(notification: Notification) {
        self.path = "/3/device/\(notification.deviceToken)"
        var headers = [String:AnyObject]()
        if let ID = notification.ID?.UUIDString {
            headers["apns-id"] = ID
        }
        if let expirationDate = notification.expirationDate {
            headers["apns-expiration"] = expirationDate.timeIntervalSince1970
        }
        if let priority = notification.priority {
            headers["apns-priority"] = priority.rawValue
        }
        if let topic = notification.topic {
            headers["apns-topic"] = topic
        }
        headers["content-length"] = notification.contentLength
        self.headers = headers
    }
}

protocol Response {

}

struct GoAwayResponse: Response {
    let goAway: GoAway
}

enum ResponseCode: Int {
    case Success = 200
    case BadRequest = 400
    /// There was an error with the certificate.
    case CertificateError = 403
    /// The request used a bad `:method` value. Only POST requests are supported.
    case BadMethod = 405
    // TODO: Return GoAway here too
    /// The device token is no longer active for the topic.
    case InvalidDeviceToken = 410
    /// The notification payload was too large.
    case PayloadTooLarge = 413
    /// The server received too many requests for the same device token.
    case TooManyRequests = 429
    /// Internal server error.
    case InternalServerError = 500
    /// The server is shutting down and unavailable.
    case ServerUnvailable = 503
}
