require 'roar/representer/transport/net_http'

module Roar
  # Gives HTTP-power to representers. They can serialize, send, process and deserialize HTTP-requests.
  module Representer
    module Feature
      module HttpVerbs
        def self.included(base)
          base.extend ClassMethods
        end
        
        
        module ClassMethods
          # GETs +url+ with +format+ and returns deserialized represented object.
          def get(*args)
            new.get(*args)
          end
        end
        
        
        # Serializes the object, POSTs it to +url+ with +format+, deserializes the returned document
        # and updates properties accordingly.
        def post(url, format)
          # DISCUSS: what if a redirect happens here?
          document = http.post_uri(url, serialize, format).body
          deserialize(document)
        end
        
        # GETs +url+ with +format+, deserializes the returned document and updates properties accordingly.
        def get(url, format)
          document = http.get_uri(url, format).body
          deserialize(document)
        end
        
        # Serializes the object, PUTs it to +url+ with +format+, deserializes the returned document
        # and updates properties accordingly.
        def put(url, format)
          document = http.put_uri(url, serialize, format).body
          deserialize(document)
        end
        
        # TODO: implement delete, patch.
      private
        def http
          Transport::NetHTTP.new
        end
      end
    end
  end
end
