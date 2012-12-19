require 'net/http'
class DefaultController < ApplicationController

  def post_hash_via_net
    #payload = { key: '123' }

    payload = { "available_now"=>[ {"account_id"=>567, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
                                {"account_id"=>890, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
                                {"account_id"=>891, "relationship_type"=>"available_now", "product_id"=>2222, "name"=>"Old Dress Available", "availability_copy"=>"", "price"=>"$235.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/old_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"} ] }
    #rows = payload["available_now"]

    Net::HTTP.post_form(uri, payload)
    #Net::HTTP.post_form(uri, { "available_now" => rows[0] })

    render text: 'A-OK', status: 200
  end

  def post_hash_via_faraday
    conn = Faraday.new(url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    #payload = { :name => 'Maguro' }
    payload = { "available_now"=>[ {"account_id"=>567, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
                                {"account_id"=>890, "relationship_type"=>"available_now", "product_id"=>1111, "name"=>"New Dress Available", "availability_copy"=>"", "price"=>"$135.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/new_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"},
                                {"account_id"=>891, "relationship_type"=>"available_now", "product_id"=>2222, "name"=>"Old Dress Available", "availability_copy"=>"", "price"=>"$235.99", "sdp_url"=>"http://www.modcloth.com/shop/dress/old_dress", "photo_url_large"=>"http://productshots2.modcloth.com/1111_large.jpg?1350941867", "photo_url_medium"=>"http://productshots2.modcloth.com/1111_medium.jpg?1350941867", "order"=>"Thu, 13 Dec 2012 20:37:52 UTC +00:00"} ] }

    conn.post path, payload

    render text: 'B-OK', status: 200
  end

  private

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