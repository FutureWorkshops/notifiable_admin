module Grocer
  class SSLConnection
    def connect
      context = OpenSSL::SSL::SSLContext.new
      context.key  = OpenSSL::PKey::RSA.new(certificate, passphrase)
      context.cert = OpenSSL::X509::Certificate.new(certificate)

      @sock            = TCPSocket.new(gateway, port)
      @sock.setsockopt   Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true
      @ssl             = OpenSSL::SSL::SSLSocket.new(@sock, context)
      @ssl.sync        = true
      @ssl.connect
    end
  end
end