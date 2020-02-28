# frozen_string_literal: true

# Helpers for navbar partial
module VerenigingenLists
    def current_child_of(item)
        child_of(item, @item)
    end
  
    def child_of(parent, child)
        children_of(parent).include?(child)
    end
  
    # Returns every navigable item
    # A navigable item contains the :navigable attribute
    # Optionally contains an order attribute, determining the order in the navbar
    def themes
        @items.find_all("**/verenigingen/*").map{|x| x[:themas]}.flatten.uniq.compact.map{|x| x[:naam]}
    end
    def konvents
        @items.find_all("**/verenigingen/*").map{|x| x[:konvent]}.uniq.compact
    end
  end