require 'json'
require 'nokogiri'

module SearchHelper

    class CreateFullTextIndex
        COMMON_WORDS = %w{ a about above across ... } unless defined?(COMMON_WORDS)

        def initialize(articles)
            @articles = articles
        end

        def call
            @articles.map do |item|
                words = item.raw_content().downcase.split(/\W+/)
                keywords = words.uniq - COMMON_WORDS
                {
                    url: item.path,
                    id: item[:id],
                    title: item[:titel],
                    verkort: item[:verkorte_naam],
                    konvent: item[:konvent],
                    body: keywords.join(" ")
                }
            end.to_a
        end
    end

    def partial_verenigingen
        @items.find_all("**/verenigingen/*").map do |x|
        {
            titel: x[:titel] || x[:naam],
            url: x.path,
            konvent: x[:konvent],
            abbrev: abbreviation(x),
            kind: "vereniging",
            text: text_segment(x.compiled_content)
        }
        end
    end

    def partial_konventen
        @items.find_all("**/konventen/*").map do |x|
        {
            titel: x[:titel] || x[:naam],
            url: x.path,
            abbrev: abbreviation(x),
            kind: "konvent",
            text: text_segment(x.compiled_content)
        }
        end
    end
end
