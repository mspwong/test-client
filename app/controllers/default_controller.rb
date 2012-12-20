require 'net/http'
class DefaultController < ApplicationController

  def post_hash_via_net
    #payload = { "payload"=>[ {"account_id"=>567, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
    #                            {"account_id"=>890, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
    #                            {"account_id"=>891, "relationship_type"=>"available_now", "product_id"=>2222, "name"=>"Old Dress Available", "availability_copy"=>"", "price"=>"$235.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/old_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"} ] }
    payload = { payload: samples.as_json }

    Net::HTTP.post_form(uri, payload)

    render text: 'A-OK', status: 200
  end

  def post_hash_via_faraday
    conn = Faraday.new(url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    #payload = { "payload"=>[ {"account_id"=>567, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
    #                            {"account_id"=>890, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
    #                            {"account_id"=>891, "relationship_type"=>"available_now", "product_id"=>2222, "name"=>"Old Dress Available", "availability_copy"=>"", "price"=>"$235.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/old_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"} ] }
    payload = { payload: samples.as_json }

    conn.post path, payload

    render text: 'B-OK', status: 200
  end

  private

  def samples
    @samples ||= [["New Dress", 123, 9999], ["New Top", 555, 3099], ['New Skirt', 333, 7599]].map do |item|
          sample = Sample.new
          sample.name = item[0]
          sample.product_id = item[1]
          sample.price = item[2]
          sample.save
          sample
        end
  end

  def uri
    URI.parse(url << path)
  end

  def url
    "http://localhost:3000"
  end

  def path
    "/post-hash"
  end

end