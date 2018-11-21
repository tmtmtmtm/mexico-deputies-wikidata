#!/bin/env ruby
# encoding: utf-8

require 'pry'
require 'wikidata/fetcher'

es_cat = WikiData::Category.new('Categoría:Diputados_de_la_LXII_Legislatura_de_México', 'es').member_titles |
         WikiData::Category.new('Categoría:Diputados_de_la_LXIII_Legislatura_de_México', 'es').member_titles

en_62 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/LXII_Legislature_of_the_Mexican_Congress',
  after: '//span[@id="Deputies"]',
  before: '//span[@id="References"]',
  xpath: '//table//tr[td]//td[position()=2 or position()=5]//a[not(@class="new")]/@title',
)

en_63_area = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/LXIII_Legislature_of_the_Mexican_Congress',
  after: '//span[@id="Deputies_by_single-member_district_(relative_majority)"]',
  before: '//span[@id="Deputies_by_proportional_representation"]',
  xpath: '//table//tr[td]//td[position()=3 or position()=7]//a[not(@class="new")]/@title',
)

en_63_pr = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/LXIII_Legislature_of_the_Mexican_Congress',
  after: '//span[@id="Deputies_by_proportional_representation"]',
  before: '//span[@id="See_also"]',
  xpath: '//table//tr[td]//td[position()=2 or position()=5]//a[not(@class="new")]/@title',
)

query = <<SPARQL
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39 wd:Q18534310 ; pq:P2937 ?term ] .
    ?term p:P31/pq:P1545 ?ordinal .
    FILTER (xsd:integer(?ordinal) >= 62)
  }
SPARQL
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { es: es_cat, en: en_62 | en_63_area | en_63_pr })
