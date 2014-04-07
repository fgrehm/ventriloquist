require 'spec_helper'

require Vagrant.source_root.join('plugins/provisioners/docker/client')
require 'ventriloquist/services_builder'

describe VagrantPlugins::Ventriloquist::ServicesBuilder do
  Service = VagrantPlugins::Ventriloquist::Service

  let(:docker_client) { instance_double(VagrantPlugins::Docker::Client, container_running?: false, run_container: false) }

  let(:pg_cfg)       { {image: 'user/pg-9.2'} }
  let(:custom_mapping) { {'mysql' => custom_service} }
  let(:custom_service) { Class.new(Service) }
  let(:svcs_configs) { [
    {pg: pg_cfg},
    ['some-service'],
    'mysql-1.2',
    {name: {type: 'mysql'}},
    {api_db: {vimage: 'mysql-2.1'}}
  ] }

  let(:services)  { described_class.new(svcs_configs, custom_mapping).build(docker_client) }
  let(:pg)        { services[0] }
  let(:other)     { services[1] }
  let(:mysql)     { services[2] }
  let(:mysql_2)   { services[3] }
  let(:vimage_ex) { services[4] }

  it 'builds a list of service objects' do
    expect(services.size).to eq(5)
    expect(services.all?{|s| s.is_a?(Service)}).to be_truthy
  end

  it 'uses container name as type' do
    expect(mysql).to be_a(custom_service)
  end

  it 'looks up service class by type name' do
    expect(mysql_2).to be_a(custom_service)
  end

  it 'sets the docker client for services' do
    expect(pg.docker_client).to eq(docker_client)
  end

  it 'configures services using defined configs' do
    expect(pg.config).to eq(pg_cfg)
  end

  it 'prepends "fgrehm/ventriloquist-" to image names if image config is not provided' do
    expect(mysql.config[:image]).to eq('fgrehm/ventriloquist-mysql-1.2')
  end

  it 'expands vimage' do
    expect(vimage_ex.config[:image]).to eq('fgrehm/ventriloquist-mysql-2.1')
  end

  it 'sets the service name' do
    expect(pg.name).to eq('pg')
    expect(mysql.name).to eq('mysql-1.2')
  end
end
