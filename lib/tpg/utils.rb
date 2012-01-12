module Tpg
  class Utils
    def self.md5_from_meta(attrs=[])
       Digest::MD5.hexdigest(attrs.join)
    end
  end
end
