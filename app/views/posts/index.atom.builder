atom_feed do |feed|
  feed.title "Deutschland, Deutschland"
  feed.updated @posts.maximum(:updated_at)
  
  @posts.each do |post|
    feed.entry post do |entry|
      entry.title post.title
      entry.content post.content.bbcode_to_html_with_formatting(Post.bbtags).html_safe
      entry.author do |author|
        author.name post.user.name
      end
    end
  end
end