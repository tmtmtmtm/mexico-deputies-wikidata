#!/bin/env ruby
# encoding: utf-8

require 'pry'
require 'wikidata/fetcher'

es_cat = WikiData::Category.new('Categoría:Diputados_de_la_LXII_Legislatura_de_México', 'es').member_titles |
         WikiData::Category.new('Categoría:Diputados_de_la_LXIII_Legislatura_de_México', 'es').member_titles

en_names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/LXII_Legislature_of_the_Mexican_Congress',
  after: '//span[@id="Deputies"]',
  before: '//span[@id="References"]',
  xpath: '//table//tr[td]//td[position()=2 or position()=5]//a[not(@class="new")]/@title',
)

EveryPolitician::Wikidata.scrape_wikidata(names: { es: es_cat, en: en_names })
