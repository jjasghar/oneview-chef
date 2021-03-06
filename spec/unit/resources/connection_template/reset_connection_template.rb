require_relative './../../../spec_helper'

describe 'oneview_test::ethernet_network_reset_connection_template' do
  let(:resource_name) { 'connection_template' }
  include_context 'chef context'
  include_context 'shared context'

  it 'updates it searching by the Ethernet Network' do
    fake_ethernet = OneviewSDK::EthernetNetwork.new(@client, connectionTemplateUri: 'fake/connection-template')
    allow(OneviewSDK::EthernetNetwork).to receive(:find_by).and_return([fake_ethernet])
    expect_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:get_default).and_return({})
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:exists?).and_return(true)
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:like?).and_return(false)
    expect_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:update).and_return(true)
    expect(real_chef_run).to reset_oneview_connection_template('ConnectionTemplate2')
  end

  it 'leave it as is since it is up to date' do
    fake_ethernet = OneviewSDK::EthernetNetwork.new(@client, connectionTemplateUri: 'fake/connection-template')
    allow(OneviewSDK::EthernetNetwork).to receive(:find_by).and_return([fake_ethernet])
    expect_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:get_default).and_return({})
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:exists?).and_return(true)
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::ConnectionTemplate).to receive(:like?).and_return(true)
    expect_any_instance_of(OneviewSDK::ConnectionTemplate).to_not receive(:update)
    expect(real_chef_run).to reset_oneview_connection_template('ConnectionTemplate2')
  end
end
