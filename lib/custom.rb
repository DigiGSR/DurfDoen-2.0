module Custom
    def filter_lang(content, lang)
        out = []

        adding = true
        content.each_line do |line|
            if lang_end(line)
                adding = true
                next
            end

            if adding
                if lang_start(line)
                    adding = lang.to_s.eql? line[6..-2]
                    next
                end
                out.push(line)
            end
        end

        out.join('')
    end

    def lang_end(line)
        line.start_with?("%langend")
    end

    def lang_start(line)
        line.start_with?("%lang=")
    end
end
