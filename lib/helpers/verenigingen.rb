# frozen_string_literal: true

# Helpers for verenigingen
module VerenigingenHelper
    # Returns every navigable item
    # A navigable item contains the :navigable attribute
    # Optionally contains an order attribute, determining the order in the navbar
    def themes
        @items.find_all("**/verenigingen/*").map{|x| x[:themas]}.flatten.uniq.compact
    end
    def konvents
        @items.find_all("**/verenigingen/*").map{|x| x[:konvent]}.uniq.compact
    end
    def evenementen
      @items.find_all("**/evenementen/*")
    end
    def verenigingen
        @items.find_all("**/verenigingen/*").map{|x| {
            "titel" => x[:titel],
            "naam" => x[:naam],
            "konvent" => x[:konvent],
            "themas" => x[:themas]
        }}.to_a
    end
    def abbreviation(item)
        item.identifier.without_ext.split('/').last
    end

    def image_url(item)
      if item[:image].nil?
        "https://dsa.ugent.be/api/verenigingen/#{ abbreviation item }/logo?size=medium"
      else
        item[:image]
      end
    end

    def image_tag(item)
      "<img src='#{ image_url item }' alt='#{ item[:name] } logo' />"
    end
end
