require 'spec_helper'

require Vagrant.source_root.join('plugins/communicators/ssh/communicator')
require Vagrant.source_root.join('plugins/provisioners/docker/client')

require 'ventriloquist/service'

describe VagrantPlugins::Ventriloquist::Service do
  let(:docker_client) { instance_double(VagrantPlugins::DockerProvisioner::Client, container_running?: false, run_container: false) }
  let(:communicator)  { instance_double(VagrantPlugins::CommunicatorSSH::Communicator, sudo: true) }
  let(:ui)            { instance_double(Vagrant::UI::Interface, info: true) }
  let(:env)           { instance_double(Vagrant::Environment, ui: ui) }
  let(:machine)       { instance_double(Vagrant::Machine, communicate: communicator, env: env) }

  let(:service_name) { 'dbserver' }
  let(:service_conf) { { image: 'user/dbserver', args: '--dns 127.0.0.1' } }

  subject { described_class.new(service_name, service_conf, docker_client) }

  before { subject.provision(machine) }

  context 'given the container has not been created' do
    it 'runs the configured container' do
      expect(docker_client).to have_received(:run_container).with(service_conf)
    end

    it 'creates a directory for keeping container id files' do
      expect(communicator).to have_received(:sudo).with('mkdir -p /var/lib/ventriloquist/cids')
    end

    it 'assigns a cidfile based on the service name' do
      expected_cidfile = "#{described_class::CONTAINER_IDS_PATH}/#{service_name}"
      expect(docker_client).to have_received(:run_container).with(hash_including(cidfile: expected_cidfile))
    end

    it 'passes on additional args' do
      expect(docker_client).to have_received(:run_container).with(hash_including(args: "--dns 127.0.0.1"))
    end
  end

  context 'given the container has already been created' do
    let(:docker_client) { double(VagrantPlugins::DockerProvisioner::Client, container_running?: true, run_container: true) }

    it 'does not attempt to run container' do
      expect(docker_client).to_not have_received(:run_container)
    end
  end
end
