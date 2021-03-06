require 'open-uri'
require 'json'
require 'csv'
require 'active_support/all'
require 'zipruby'

module GeoNamesAPI

  mattr_accessor :url
  self.url = 'http://api.geonames.org/'

  mattr_accessor :lang
  self.lang = :en
  
  mattr_accessor :username
  self.username = 'demo'

  mattr_accessor :token
  self.token = nil

  mattr_accessor :style
  self.style = :full

  mattr_accessor :logger
  self.logger = nil

  mattr_accessor :retries
  self.retries = 3

  mattr_accessor :max_sleep_time_between_retries
  self.max_sleep_time_between_retries = 5

  def self.params
    {
      lang: lang,
      username: username,
      token: token,
      style: style
    }.delete_if{ |k, v| v.blank? }
  end
    
end

Dir[File.dirname(__FILE__) + '/geonames_api/*.rb'].each do |file|
  tgt = File.basename(file, File.extname(file))
  GeoNamesAPI.autoload tgt.camelize, "geonames_api/#{tgt}"
end
