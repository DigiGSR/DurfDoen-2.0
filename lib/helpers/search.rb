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

    def to_partials_search(items)
        my_hash = {}

        items.each do |item|
          my_hash[(item.path)] = {
              html: (render '/partials/pretty_link.*', :item => item).gsub("\n", ''),
              titel: item[:titel] || item[:naam]
          }
        end
        my_hash.to_json
    end
end
