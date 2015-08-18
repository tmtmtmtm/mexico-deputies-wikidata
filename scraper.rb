#!/bin/env ruby
# encoding: utf-8

require 'json'
require 'pry'
require 'rest-client'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'mediawiki_api'

def candidates
  morph_api_url = 'https://api.morph.io/tmtmtmtm/mexico-deputies-wikipedia/data.json'
  morph_api_key = ENV["MORPH_API_KEY"]
  result = RestClient.get morph_api_url, params: {
    key: morph_api_key,
    query: "select DISTINCT(wikipedia__en) as wikiname from data"
  }
  JSON.parse(result, symbolize_names: true)
end

candidates.each_with_index do |title, i|
  puts i if (i % 50).zero?
  data = WikiData::Fetcher.new(title: title).data('es') rescue nil
  unless data
    warn "No data for #{p}"
    next
  end
  ScraperWiki.save_sqlite([:id], data)
end

