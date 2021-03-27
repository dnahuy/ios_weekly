[Original Link](https://stavrosschizas.com/post/encrypt-dns-in-ios-14-applications/)

# Encrypt DNS in iOS 14 applications

## Introduction
This blog introduce how we can encrypt DNS queries over HTTPS (DoH) or TLS (DoT). So we can prevent unencrypted DNS from eavesdropping.

## Unencrypted DNS

```swift
let session = URLSession.init(configuration: config)
URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data, error == nil else {
        print(error ?? "Unknown error")
        return
    }

    let contents = String(data: data, encoding: .utf8)
    print(contents!)
    PlaygroundPage.current.finishExecution()
}.resume()
```
And we can use ___Wireshark___ to eavesdrop DNS queries.

## Encrypted DNS using DoH/DoT
On iOS 14, to make use of DoH, we need to configure the NWParameters.PrivacyContext with a DNS (which supports DoH) resolver’s central host HTTPS and its backup hosts IPs.

```swift
enum DoHConfigurarion: Hashable {
    case cloudflare
    
    var httpsURL: URL {
        switch self {
        case .cloudflare:
            return URL(string: "https://cloudflare-dns.com/dns-query")!
        }
    }
    
    var serverAddresses: [NWEndpoint] {
        switch self {
        case .cloudflare:
            return [
                NWEndpoint.hostPort(host: "1.1.1.1", port: 443),
                NWEndpoint.hostPort(host: "1.0.0.1", port: 443),
                NWEndpoint.hostPort(host: "2606:4700:4700::1111", port: 443),
                NWEndpoint.hostPort(host: "2606:4700:4700::1001", port: 443)
            ]
        }
    }
}
```

Using
```swift
let secureDNS = DoHConfigurarion.cloudflare
NWParameters.PrivacyContext.default.requireEncryptedNameResolution(
    true,
    fallbackResolver: .https(secureDNS.httpsURL, serverAddresses: secureDNS.serverAddresses)
)

URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data, error == nil else {
        print(error ?? "Unknown error")
        return
    }

    let contents = String(data: data, encoding: .utf8)
    print(contents!)
    PlaygroundPage.current.finishExecution()
}.resume()
```