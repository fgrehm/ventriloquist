require 'spec_helper'

require 'vocker/docker_client'
require Vagrant.source_root.join('plugins/communicators/ssh/communicator')

require 'ventriloquist/service'

describe VagrantPlugins::Ventriloquist::Service do
  verify_contract(:service)

  let(:docker_client) { fake(:docker_client, container_running?: false) }
  fake(:communicator) { VagrantPlugins::CommunicatorSSH::Communicator }
  fake(:ui)           { Vagrant::UI::Interface }
  let(:env)           { fake(:environment, ui: ui) }
  let(:machine)       { fake(:machine, communicate: communicator, env: env) }

  let(:service_name) { 'dbserver' }
  let(:service_conf) { { image: 'user/dbserver', tag: 'latest' } }

  subject { described_class.new(service_name, service_conf, docker_client) }

  before { subject.provision(machine) }

  context 'given the container has not been created' do
    it 'runs the configured container' do
      expect(docker_client).to have_received.run_container(service_conf)
    end

    it 'creates a directory for keeping container id files' do
      expect(communicator).to have_received.sudo('mkdir -p /var/lib/ventriloquist/cids')
    end

    it 'assigns a cidfile based on the service name' do
      expected_cidfile = "#{described_class::CONTAINER_IDS_PATH}/#{service_name}"
      expect(docker_client).to have_received.run_container(with{|c| c[:cidfile] == expected_cidfile})
    end

    it 'sets dns to 127.0.0.1 to reduce latency' do
      expect(docker_client).to have_received.run_container(with{|c| c[:dns] == "127.0.0.1"})
    end
  end

  context 'given the container has already been created' do
    let(:docker_client) { fake(:docker_client, container_running?: true) }

    it 'does not attempt to run container' do
      expect(docker_client).to_not have_received.run_container(any_args)
    end
  end
end
