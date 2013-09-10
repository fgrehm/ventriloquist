require 'spec_helper'

require 'vocker/docker_client'
require 'ventriloquist/services_builder'

describe VagrantPlugins::Ventriloquist::ServicesBuilder do
  Service = VagrantPlugins::Ventriloquist::Service

  verify_contract(:services_builder)

  fake(:docker_client)

  let(:pg_cfg)       { {image: 'user/pg', tag: '9.2'} }
  let(:svcs_configs) { [{pg: pg_cfg}, ['some-service'], 'mysql:1.2'] }
  let(:custom_mapping) { {'mysql' => custom_service} }
  let(:custom_service) { Class.new(Service) }

  let(:services) { described_class.new(svcs_configs, custom_mapping).build(docker_client) }
  let(:pg)       { services[0] }
  let(:other)    { services[1] }
  let(:mysql)    { services[2] }

  it 'builds a list of service objects' do
    expect(services).to have(3).items
    expect(pg).to be_a(Service)
    expect(other).to be_a(Service)
    expect(mysql).to be_a(custom_service)
  end

  it 'sets the docker client for services' do
    expect(pg.docker_client).to eq(docker_client)
  end

  it 'configures services using defined configs' do
    expect(pg.config).to eq(pg_cfg)
  end

  it 'extracts tag from image name' do
    expect(mysql.config[:tag]).to eq('1.2')
  end

  it 'defaults tag to "latest"' do
    expect(other.config[:tag]).to eq('latest')
  end

  it 'prepends "fgrehm/ventriloquist-" to image names if image config is not provided' do
    expect(mysql.config[:image]).to eq('fgrehm/ventriloquist-mysql')
  end

  it 'sets the service name' do
    expect(pg.name).to eq('pg')
    expect(mysql.name).to eq('mysql')
  end
end
