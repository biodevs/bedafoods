require 'rails_helper'

RSpec.describe "Api::V1::Restaurants", type: :request do
  ########## INDEX ##########
  describe "GET /restaurants" do

    context "With Valid Restaurants" do
      before do
        @restaurant1 = create(:restaurant)
        @restaurant2 = create(:restaurant)

        get "/api/v1/restaurants", params: {}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "returns restaurant list with 2 restaurants" do
        expect(json.count).to eql(2)
      end

      it "returned Restaurants have right datas" do
        expect(json[0]).to eql(JSON.parse(@restaurant1.to_json))
        expect(json[1]).to eql(JSON.parse(@restaurant2.to_json))
      end
    end
  end  
  
  ########## SHOW ##########
  describe "GET /restaurants/:friendly_id" do
    context "When restaurant exists" do
      before do
        @restaurant = create(:restaurant)
        @plate1 = create(:plate, restaurant: @restaurant)
        @plate2 = create(:plate, restaurant: @restaurant)        
        get "/api/v1/restaurants/#{@restaurant.friendly_id}", params: {}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "returned restaurant with right datas" do
        expect(json.except('plates')).to eql(JSON.parse(@restaurant.to_json))
      end
      
      it 'returned associated plates' do
        expect(json['plates'].first).to eql(@plate1.to_json)
        expect(json['plates'].last).to eql(@plate2.to_json)
      end
    end

    context "When restaurant don't exists" do
      it "returns 404" do
        get "/api/v1/restaurants/#{FFaker::Lorem.word}", params: {}
        expect_status(404)
      end
    end
  end  
  
  ####### CREATE ##########
  describe "POST /restaurants" do
    
    context "And with valid params" do
      before do
        @restaurant_attributes = attributes_for(:restaurant)
        post "/api/v1/restaurants", params: {restaurant: @restaurant_attributes}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "restaurant are created with correct data" do
        @restaurant_attributes.each do |field|
          expect(restaurant.first[field.first]).to eql(field.last)
        end
      end

      it "Returned data is correct" do
        @restaurant_attributes.each do |field|
          expect(json[field.first.to_s]).to eql(field.last)
        end
      end
    end

    context "And with invalid params" do
      before do
        post "/api/v1/restaurants", params: {restaurant: {}}
      end

      it "returns 400" do
        expect_status(400)
      end
    end
  end
  
  ######### UPDATE #########
  describe "PUT /restaurants/:friendly_id" do
    

    context "When restaurant exists" do

      before do
        @restaurant = create(:restaurant)
        @restaurant_attributes = attributes_for(:restaurant, id: @restaurant.id)
        put "/api/v1/restaurants/#{@restaurant.friendly_id}", params: {restaurant: @restaurant_attributes}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "restaurant are updated with correct data" do
        @restaurant.reload
        @restaurant_attributes.each do |field|
          expect(@restaurant[field.first]).to eql(field.last)
        end
      end

      it "Returned data is correct" do
        @restaurant_attributes.each do |field|
          expect(json[field.first.to_s]).to eql(field.last)
        end
      end

    end

    context "When restaurant dont exists" do
      before do
        @restaurant_attributes = attributes_for(:restaurant)
      end

      it "returns 404" do
        put "/api/v1/restaurants/#{FFaker::Lorem.word}", params: {restaurant: @restaurant_attributes}
        expect_status(404)
      end
    end
  end  
  
  ######### DELETE ##########
  describe "DELETE /restaurants/:friendly_id" do

    context "When restaurant exists" do

      before do
        @restaurant = create(:restaurant)
        delete "/api/v1/restaurants/#{@restaurant.friendly_id}", params: {}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "restaurant are deleted" do
        expect(restaurant.all.count).to eql(0)
      end
      it "associated plate are deleted" do
        expect(Plate.all.count).to eql(0)
      end      
    end

    context "When restaurant dont exists" do
      it "returns 404" do
        delete "/api/v1/restaurants/#{FFaker::Lorem.word}", params: {}
        expect_status(404)
      end
    end
  end  
  
  
  
end
