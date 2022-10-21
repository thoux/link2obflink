require 'nokogiri'
require 'open-uri'

# Ne prendra pas les liens internes
root_domain = "https://www.blogduwebdesign.com/"
@doc = Nokogiri::HTML.parse(open('text.html').read)

# Ne prend pas encore en charge les liens dans les images
arr = @doc.css("a")

arr.each do |node|
  unless node[:href].include?(root_domain)
    obfusqued_hash = {
      label: node.content,
      link: node[:href],
    }
    obfusqued_link = "[obflink-text label=\"#{obfusqued_hash[:label]}\" link=\"#{obfusqued_hash[:link]}\" target=\"_blank\" class=\"test\" display=\"not_home\" rel=\"noreferrer noopener\"]"
    node.replace(obfusqued_link)
  end
end

# CTRL + B dans sublime text pour obtenir le contenu nettoyé.
puts @doc.to_html
