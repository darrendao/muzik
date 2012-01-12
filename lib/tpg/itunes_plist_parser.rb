require 'rubygems'
require 'nokogiri'

module Tpg
class ItunesPlistParser
  def self.parse(file)
    xml = Nokogiri::XML(file.read)
    playlist = []
    xml.xpath('/plist/dict/dict/dict').each do |track|
      hash = {}
      key = nil
      track.children.each do |attribute|
        if attribute.name == 'key'
          key = attribute.text
        elsif attribute.name == 'string' or attribute.name == 'integer'
          hash[key] = attribute.text
        end
      end
      playlist << hash
    end
    playlist
  end
end
end
