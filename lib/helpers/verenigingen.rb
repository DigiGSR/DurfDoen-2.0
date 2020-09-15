# frozen_string_literal: true

# Helpers for data
module VerenigingenHelper
  # Helpers for navbar partial
  def current_child_of(item)
    child_of(item, @item)
  end

  def child_of(parent, child)
    children_of(parent).include?(child)
  end

  # Data helpers
  def themas
    @items.find_all("**/themas/*")
  end

  def verenigingen_voor_thema(thema)
    @items.filter{|i| i[:themas] and i[:themas].include?(thema)}.to_a
  end

  def verenigingen_voor_konvent(konvent)
    @items.find_all("**/verenigingen/*").filter { |i| i[:konvent] == konvent }.to_a
  end

  def konventen
    @items.find_all("**/konventen/*").to_a
  end

  def evenementen
    @items.find_all("**/evenementen/*")
  end

  def projecten
    @items.find_all("**/projecten/*").to_a
  end

  def konventen_and_projecten
    konventen.union(projecten)
  end

  def verenigingen
    @items.find_all("**/verenigingen/*").map { |x| {
        "naam" => x[:naam],
        "verkorte_naam" => x[:verkorte_naam],
        "konvent" => x[:konvent],
        "themas" => x[:themas],
        "postcodes" => x[:postcodes].to_a,
    } }.to_a
  end

  def postcodes_per_vereniging
    @items.find_all("**/verenigingen/*").map { |x| {
      "postcodes" => x[:postcodes],
      "id" => x[:id]
    } }.flatten.to_a
  end


  def abbreviation(item)
    item.identifier.without_ext.split('/').last
  end

  def all_groups
    @items.find_all("**/verenigingen/*") + @items.find_all("**/konventen/*")
  end

  def image_url(item)
    if item[:image].nil?
      "https://dsa.ugent.be/api/verenigingen/#{ abbreviation item }/logo?size=medium"
    else
      item[:image]
    end
  end

  def verenigingen_random(amount)
    @items.find_all("**/verenigingen/*").map { |x| {
        "titel" => x[:titel],
        "naam" => x[:naam],
        "konvent" => x[:konvent],
        "themas" => x[:themas]
    } }.to_a.shuffle[0..amount]
  end

  def image_tag(item)
    "<img src='#{ image_url item }' alt='#{ item[:naam] } logo' />"
  end
end
