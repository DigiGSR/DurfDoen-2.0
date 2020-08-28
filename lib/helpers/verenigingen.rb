# frozen_string_literal: true

module VerenigingenLists
    # Helpers for navbar partial
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
        @items.find_all("**/verenigingen/*").map{|x| x[:themas]}.flatten.uniq.compact
    end
    def konventen
        @items.find_all("**/konventen/*").to_a
    end
    def projecten
      @items.find_all("**/projecten/*").to_a
    end
    def konventen_and_projecten
        konventen.union(projecten)
    end
    def verenigingen
        @items.find_all("**/verenigingen/*").map{|x| {
            "naam" => x[:naam],
            "verkorte_naam" => x[:verkorte_naam],
            "konvent" => x[:konvent],
            "themas" => x[:themas]
        }}.to_a
    end
    def abbreviation(item)
        item.identifier.without_ext.split('/').last
    end
    def image_url(item)
        "https://aniekwendt.nl/wp-content/upload_folders/aniekwendt.nl/mijn-puppy-komt-niet-als-ik-roep.jpg"
    end

    def themas
        @items.find_all("**/themas/*")
    end

  end
