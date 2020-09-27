
require 'httparty'
require 'zip'
input = HTTParty.get("https://info.gesundheitsministerium.at/data/data.zip").body
ml = Zip::InputStream.open(StringIO.new(input))
e = ml.get_next_entry
while e.name != "Bezirke.csv"
    e = ml.get_next_entry
end
t = CSV.parse(e.get_input_stream.read, headers: true, col_sep: ";")