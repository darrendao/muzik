module MediaPlayersHelper
  def portal_url(url)
    ret = ""
    if url.nil?
      ret = "n/a"
    else
      link_to url, url
    end
  end
end
