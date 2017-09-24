require "net/dns"

class ConnectionStatus
  class API
    include HTTParty

    format :json

    def current_ip
      self.class.get('https://api.ipify.org?format=json').parsed_response['ip']
    end

    def hostname_for_ip(ip)
      resolver = Net::DNS::Resolver.new(retry: 3, udp_timeout: 5).search(ip)
      answer = resolver.answer.first || resolver.authority.first
      if answer && !answer.value.empty?
        answer.value.split(" ").first[0..-2]
      end
    rescue Net::DNS::Resolver::NoResponseError
      nil
    end

    def provider_for_hostname(hostname)
      components = hostname.split('.')
      return unless components.count >= 2
      components[-2..-1].join('.')
    end
  end
end
