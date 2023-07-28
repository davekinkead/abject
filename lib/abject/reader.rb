module Abject
  module Reader

    private

    # Save time copy & pasting old methods by doing it at run time!
    def parse_method(location)
      File.readlines(location[0])[location[1].to_i..-1].join.split("end\n").first
    end
  end
end
