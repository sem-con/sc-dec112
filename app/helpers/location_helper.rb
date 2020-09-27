module LocationHelper
    def get_gps_location(call_id)
        raw = Store.find_by_call_id(call_id.to_s).item
        # TODO get GPS location information

        # TODO perform reverse lookup

        return {city: "Vienna", street: "", zip: "1010"} # parsed address information from reverse lookup
    end
end
