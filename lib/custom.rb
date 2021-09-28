module Custom
    def filter_lang(content, lang)
        if content.class == Array
            content.map { |x| filter_lang(x, lang) }
        elsif content.respond_to?(:to_str)
            filter_lang_str(content, lang)
        elsif content.class == Hash
            filter_lang_hash(content, lang)
        else
            content
        end
    end

    def filter_lang_hash(content, lang)
        content.map { |k, str|
            [k, filter_lang(str, lang)]
          }.to_h
    end

    def filter_lang_str(content, lang)
        out = []

        adding = true
        content.split(/(\$lang=..\$|\$langend\$)/).each do |part|
            part = part.strip
            if lang_end(part)
                adding = true
                next
            end

            if lang_start(part)
                adding = lang.to_s.eql? part[-3..-2]
                next
            end

            if adding
                out.push(part)
            end
        end

        out.join('')
    end

    def lang_end(line)
        line.start_with?("$langend")
    end

    def lang_start(line)
        line.start_with?("$lang=")
    end
end
