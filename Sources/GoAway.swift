import Foundation

/// Indicates the APNs server has initiated a termination of the connection.
struct GoAway {
    /// A reason that the termination has been initiated.
    /// seealso: https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/APNsProviderAPI.html#//apple_ref/doc/uid/TP40008194-CH101-SW5
    enum Reason: String {
        /// The message payload was empty.
        case PayloadEmpty
        /// The message payload was too large. The maximum payload size is 4096 bytes.
        case PayloadTooLarge
        /// The `apns-topic` was invalid.
        case BadTopic
        /// Pushing to this topic is not allowed.
        case TopicDisallowed
        /// The `apns-id` value is bad.
        case BadMessageId
        /// The apns-expiration value is bad.
        case BadExpirationDate
        /// The `apns-priority` value is bad.
        case BadPriority
        /// The device token is not specified in the request `:path`. Verify
        /// that the `:path` header contains the device token.
        case MissingDeviceToken
        /// The specified device token was bad. Verify that the request contains
        /// a valid token and that the token matches the environment.
        case BadDeviceToken
        /// The device token does not match the specified topic.
        case DeviceTokenNotForTopic
        /// The device token is inactive for the specified topic.
        case Unregistered
        /// One or more headers were repeated.
        case DuplicateHeaders
        /// The client certificate was for the wrong environment.
        case BadCertificateEnvironment
        /// The certificate was bad.
        case BadCertificate
        /// The specified action is not allowed.
        case Forbidden
        /// The request contained a bad `:path` value.
        case BadPath
        /// The specified `:method` was not `POST`.
        case MethodNotAllowed
        /// Too many requests were made consecutively to the same device token.
        case TooManyRequests
        /// Idle time out.
        case IdleTimeout
        /// The server is shutting down.
        case Shutdown
        /// An internal server error occurred.
        case InternalServerError
        /// The service is unavailable.
        case ServiceUnavailable
        /// The apns-topic header of the request was not specified and was
        /// required. The apns-topic header is mandatory when the client is
        /// connected using a certificate that supports multiple topics.
        case MissingTopic
    }

    /// Reason that the GOAWAY termination has been initiated.
    let reason: Reason

    /// The last time at which APNs confirmed that the device token was no longer
    /// valid for the topic.
    let timestamp: NSDate
}
