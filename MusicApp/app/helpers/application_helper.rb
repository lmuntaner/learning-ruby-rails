module ApplicationHelper
  def ugly_lyrics(lyrics)
    html_lyric = "<p><pre>"
    
    lyrics_array = lyrics.split("\n")
    lyrics_array.each do |line|
      html_lyric += "&#9835; #{h(line)}"
    end
    html_lyric += "</pre></p>"
    
    html_lyric.html_safe
  end
end
