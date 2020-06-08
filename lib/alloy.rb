require 'httparty'
require 'base64'

class Alloy
  def self.method_missing(m, *args, &block)
    options = args.any? ? args[0] : {}
    method = options[:method] || "post"
    uri = "#{Rails.application.credentials.alloy[:uri]}#{m}"
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => auth_param,
      "Alloy-Sandbox" => 'true',
      'Alloy-Sandbox-Services' => ''
    }.merge(options[:headers].to_h)

    JSON.parse(HTTParty.send(method, uri, {headers: headers, body: (options[:body] || {}).to_json}).body)
  end

  private

  def self.auth_param
    "Basic #{encoded}"
  end

  def self.encoded
    Base64.strict_encode64 "#{Rails.application.credentials.alloy[:token]}:#{Rails.application.credentials.alloy[:secret]}"
  end
end
