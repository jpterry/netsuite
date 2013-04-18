require 'spec_helper'

describe NetSuite::Actions::Delete do
  include Savon::SpecHelper

  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:internal_id => '980', :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

    before do
      delete_fixture = File.read("spec/support/fixtures/delete/delete_customer.xml")
      savon.expects(:delete).with({
        'platformMsgs:baseRef' => {},
        :attributes! => {
          'platformMsgs:baseRef' => {
            'internalId' => '980',
            'type'       => 'customer',
            'xsi:type'   => 'platformCore:RecordRef'
          }
        }
      }).returns(delete_fixture)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Delete.call(customer)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Delete.call(customer)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

end
