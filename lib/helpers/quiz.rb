require 'json'
require 'nokogiri'

module QuizHelper
    def to_partials(items)
        my_hash = {}

        items.each do |item|
            my_hash[(item[:id] || "none")] = (render '/partials/pretty_link.*', :item => item).gsub("\n", '')
        end
        my_hash.to_json
    end
end
