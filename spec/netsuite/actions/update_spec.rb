require 'spec_helper'

describe NetSuite::Actions::Update do
  include Savon::SpecHelper

  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

  context 'Customer' do
    let(:customer) { NetSuite::Records::Customer.new }
    let(:attributes) { { :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.' } }

    before do
      update_customer_fixture = File.read("spec/support/fixtures/update/update_customer.xml")
      savon.expects(:update).with(:message => {
        'platformMsgs:record' => {
          'listRel:entityId'    => 'Shutter Fly',
          'listRel:companyName' => 'Shutter Fly, Inc.'
        },
        :attributes! => {
          'platformMsgs:record' => {
            'xsi:type' => 'listRel:Customer'
          }
        }
      }).returns(update_customer_fixture)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Update.call(NetSuite::Records::Customer, attributes)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(NetSuite::Records::Customer, attributes)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

  context 'Invoice' do
    let(:invoice) { NetSuite::Records::Invoice.new }
    let(:attributes) { { :source => 'Google', :total => 100.0 } }

    before do
      update_invoice_fixture = File.read("spec/support/fixtures/update/update_invoice.xml")
      savon.expects(:update).with(:message => {
        'platformMsgs:record' => {
          'tranSales:source' => 'Google',
        },
        :attributes! => {
          'platformMsgs:record' => {
            'xsi:type' => 'tranSales:Invoice'
          }
        }
      }).returns(update_invoice_fixture)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Update.call(NetSuite::Records::Invoice, attributes)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Update.call(NetSuite::Records::Invoice, attributes)
      response.should be_kind_of(NetSuite::Response)
      response.should be_success
    end
  end

end
