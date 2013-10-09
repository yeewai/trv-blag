xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Deutschland, Deutschland"
    xml.description "Kyle + Yee's adventures through Europe"
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.cutcontent.bbcode_to_html_with_formatting(Post.bbtags).html_safe
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link posts_url(post)
        xml.guid posts_url(post)
      end
    end
  end
end