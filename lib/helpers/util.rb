module UtilHelper
    # def truncate(string, max=30)
    #     string.length > max ? "#{string[0...max]}..."  : string
    # end

    def truncate(string, max=20, delim=" ")
        parts = string.split(delim)
        parts.length > max ?
            parts[0..max].join(delim) + "..." : string
    end

    def make_some(string, backup="&nbsp;")
        string.strip().length > 0 ? string : backup
    end
end
