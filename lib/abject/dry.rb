require 'httparty'
require 'nokogiri'

class Crawler
  include HTTParty
  format :html
end

module Abject
  module DRY

    # Why copy & paste answers from stack overflow when you can curl & eval them!
    # Expects a url#answer-id and a hash of adjustments to the answer code to gsub over
    def fuck_it_just_copy_something_from_stackoverflow(url, adjustments)

      # build the adjustment lambda
      edit = "lambda { |method_string| method_string"
      adjustments.each { |k,v| edit += ".gsub('#{k}', '#{v}')" }
      edit += "}"

      # then get some of that overflow goodness
      answer = url.split('#').last
      @doc ||= Nokogiri::HTML Crawler.get(url)
      @doc.css("#answer-#{answer} code").each do |code|
        # Oh yeah, it's lambda time!
        # Eval the edit string, pass it the overflow code and eval the resulting lambda
        return eval eval(edit).call code.content
      end
    end
  end
end
