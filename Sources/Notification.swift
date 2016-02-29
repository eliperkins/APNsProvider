import Foundation

/// A push notification to be sent to a device.
struct Notification {
    /// Priority of a notification, used for delivery.
    enum Priority: Int {
        /// Send the push message immediately. Notifications with this priority
        /// must trigger an alert, sound, or badge on the target device. It is
        /// an error to use this priority for a push notification that contains
        /// only the `content-available` key.
        case Immediate = 10
        /// Send the push message at a time that takes into account power
        /// considerations for the device. Notifications with this priority
        /// might be grouped and delivered in bursts. They are throttled, and
        /// in some cases are not delivered.
        case UsingPowerConsiderations = 5
    }

    /// The device token for the target device.
    let deviceToken: String

    /// A canonical UUID that identifies the notification. If there is an error
    /// sending the notification, APNs uses this value to identify the
    /// notification to your server.
    /// Note: If you omit this header, a new UUID is created by APNs and
    ///       returned in the response.
    let ID: NSUUID?

    /// Identifies the date when the notification is no longer valid and can be
    /// discarded. If this value is non-nil, APNs stores the notification and
    /// tries to deliver it at least once, repeating the attempt as needed if it
    /// is unable to deliver the notification the first time. If the value is nil,
    /// APNs treats the notification as if it expires immediately and does not
    /// store the notification or attempt to redeliver it.
    let expirationDate: NSDate?

    /// The priority of the notification. If you omit this header, the APNs
    /// server sets the priority to `Immediate`.
    let priority: Priority?

    // TODO: Make this a computed var form payload
    /// The length of the body content. The body length must be less than or
    /// equal to 4096 bytes.
    let contentLength: Int

    /// The topic of the remote notification, which is typically the bundle ID
    /// for your app. The certificate you create in Member Center must include
    /// the capability for this topic.
    /// If your certificate includes multiple topics, you must specify a value
    /// for this header.
    /// If you omit this header and your APNs certificate does not specify
    /// multiple topics, the APNs server uses the certificate’s Subject as the
    /// default topic.
    let topic: String?

    /// The body content of your message containing the notification data.
    /// The body data must not be compressed and may be as large as 4096 bytes.
    let payload: [String:AnyObject]

    // TODO: Throw on `payload` over 4096
    // TODO: Throw on invalid `priority` given payload contents
    // TODO: Throw for topic issues given cert?
    // init() throws { }
}
