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
    def all_groups
        @items.find_all("**/verenigingen/*") + @items.find_all("**/konventen/*")
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
  end
