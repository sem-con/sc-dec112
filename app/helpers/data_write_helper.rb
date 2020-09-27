module DataWriteHelper
    def writeData(content, input, provenance, read_hash)
        # write data to container store
        new_items = []
        record_exist = false
        begin
            if content.class == String
                if content == ""
                    render plain: "",
                           status: 500
                    return
                end
                content = [content]
            end

            # write provenance
            # input_hash = read_hash #Digest::SHA256.hexdigest(input.to_json)
            prov_timestamp = Time.now.utc
            prov = Provenance.new(
                prov: provenance, 
                input_hash: read_hash,
                startTime: prov_timestamp)
            prov.save
            prov_id = prov.id


            # write data
            content = content.first
            content_orig = content
            if content["call"].to_s != ""
                content = content["call"]
            end
            record = Store.find_by_call_id(content["call_id"])
            if record.nil?
                call_id = content["call_id"].to_s
                caller_uri = content["caller_uri"].to_s
                call_state = content["state"].to_i
                created_ts = content["created_ts"].to_s
                end_ts = content["created_ts"].to_s
                end_by = ""
                messages = [content]
                new_item = {"call_id": call_id,
                            "caller_uri": caller_uri,
                            "created_ts": created_ts,
                            "state": call_state,
                            "end_ts": end_ts,
                            "end_by": end_by,
                            "messages": messages }
                my_store = Store.new(item: new_item.to_json, call_id: call_id, prov_id: prov_id)
                my_store.save
                new_items << my_store.id
            else
                record_exist = true
                record_item = JSON(record.item)
                call_id = record_item["call_id"].to_s
                caller_uri = record_item["caller_uri"].to_s

                call_state = record_item["state"].to_i
                my_state = content["state"].to_i rescue nil
                if !my_state.nil?
                    call_state = my_state
                end
                created_ts = record_item["created_ts"].to_s
                receive_ts = content["message"]["received_ts"].to_s rescue ""
                end_ts = record_item["end_ts"].to_s
                if receive_ts != ""
                    end_ts = receive_ts
                end
                end_by = record_item["end_by"].to_s
                origin = content["message"]["origin"].to_s rescue ""
                if origin != ""
                    end_by = origin
                end
                messages = record_item["messages"]
                if content_orig["method"] == "get_call"
                    messages << content_orig
                else
                    messages << content
                end
                new_item = {"call_id": call_id,
                            "caller_uri": caller_uri,
                            "created_ts": created_ts,
                            "state": call_state,
                            "end_ts": end_ts,
                            "end_by": end_by,
                            "messages": messages }
                record.update_attributes(item: new_item.to_json)
                new_items << record.id
            end

            # create receipt information
            receipt_json = createReceipt(read_hash, new_items, prov_timestamp)
            receipt_hash = Digest::SHA256.hexdigest(receipt_json.to_json)

            # finalize provenance
            revocation_key = SecureRandom.hex(16).to_s
            Provenance.find(prov_id).update_attributes(
                scope: new_items.to_s,
                receipt_hash: receipt_hash.to_s,
                revocation_key: revocation_key,
                endTime: Time.now.utc,
                input_hash: read_hash)

            # write Log
            if record_exist
                createLog({
                    "type": "update",
                    "scope": new_items.to_s})
            else
                createLog({
                    "type": "write",
                    "scope": new_items.to_s})
            end

            render json: { "receipt": receipt_hash.to_s,
                           "serviceEndpoint": ENV["SERVICE_ENDPOINT"].to_s,
                           "read_hash": read_hash,
                           "revocation_key": revocation_key },
                   status: 200

        rescue => ex
            render json: {"error": ex.to_s},
                   status: 500
        end
    end
end