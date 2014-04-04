require 'spec_helper'

require 'ventriloquist/platforms_builder'

describe VagrantPlugins::Ventriloquist::PlatformsBuilder do
  Platform = VagrantPlugins::Ventriloquist::Platform

  let(:cfg)               { {version: '13.0'} }
  let(:platforms_configs) { [{my_lang: cfg}, :your_lang, ['my_plat:version']] }
  let(:custom_mapping)    { {'my_lang' => my_lang_class, 'your_lang' => your_lang_class, 'my_plat' => my_plat_class} }

  let(:my_lang_class) do
    Class.new(Platform)
  end
  let(:your_lang_class) do
    Class.new(Platform)
  end
  let(:my_plat_class) do
    Class.new(Platform)
  end

  let(:platforms) { described_class.new(platforms_configs, custom_mapping).build }

  let(:my_lang)   { platforms[0] }
  let(:your_lang) { platforms[1] }
  let(:my_plat)   { platforms[2] }

  it 'builds a list of platform objects' do
    expect(platforms.size).to eq(3)
    expect(my_lang).to   be_a(my_lang_class)
    expect(your_lang).to be_a(your_lang_class)
    expect(my_plat).to   be_a(my_plat_class)
  end

  it 'extracts version from platform name' do
    expect(my_plat.config[:version]).to eq('version')
  end

  it 'defaults configured version to latest' do
    expect(your_lang.config[:version]).to eq('latest')
  end

  it 'configures services using defined configs' do
    expect(my_lang.config).to eq(cfg)
  end
end
