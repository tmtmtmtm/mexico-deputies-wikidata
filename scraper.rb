#!/bin/env ruby
# encoding: utf-8

require 'pry'
require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/mexico-deputies-wikipedia', column: 'wikipedia__en')
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })
