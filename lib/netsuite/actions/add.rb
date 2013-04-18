module NetSuite
  module Actions
    class Add
      include Support::Requests

      def initialize(object = nil)
        @object = object
      end

      private

      def request
        connection.call(:add, :message => request_body)
      end

      # <soap:Body>
      #   <platformMsgs:add>
      #     <platformMsgs:record xsi:type="listRel:Customer">
      #       <listRel:entityId>Shutter Fly</listRel:entityId>
      #       <listRel:companyName>Shutter Fly, Inc</listRel:companyName>
      #     </platformMsgs:record>
      #   </platformMsgs:add>
      # </soap:Body>
      def request_body
        hash = {
          'platformMsgs:record' => @object.to_record,
          :attributes! => {
            'platformMsgs:record' => {
              'xsi:type' => @object.record_type
            }
          }
        }
        if @object.respond_to?(:internal_id) && @object.internal_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:internalId'] = @object.internal_id
        end
        if @object.respond_to?(:external_id) && @object.external_id
          hash[:attributes!]['platformMsgs:record']['platformMsgs:externalId'] = @object.external_id
        end
        hash
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref]
      end

      def response_hash
        @response_hash ||= @response.to_hash[:add_response][:write_response]
      end

      module Support
        def add
          response = NetSuite::Actions::Add.call(self)
          if response.success?
            @internal_id = response.body[:@internal_id]
            true
          else
            false
          end
        end
      end

    end
  end
end
