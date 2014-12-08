module TracksHelper
  def ugly_lyrics(lyrics)
    ugly_lyrics = lyrics.lines
                        .map { |line| line.prepend("&#9835; ") }
                        .join("\n")

    "<pre>#{ugly_lyrics}</pre>".html_safe
  end
end
