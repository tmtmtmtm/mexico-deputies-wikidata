#!/bin/env ruby
# encoding: utf-8

require 'pry'
require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/LXII_Legislature_of_the_Mexican_Congress',
  after: '//span[@id="Deputies_of_the_LXII_Legislature"]',
  before: '//span[@id="References"]',
  xpath: '//table//tr[td]//td[position()=2 or position()=5]//a[not(@class="new")]/@title',
)

EveryPolitician::Wikidata.scrape_wikidata(names: { en: names })
