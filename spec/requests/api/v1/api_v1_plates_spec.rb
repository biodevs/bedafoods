require 'rails_helper'

RSpec.describe "Api::V1::Plates", type: :request do
  ########## INDEX ##########
  describe "GET /plates" do
    
    context "With Valid Plates" do
      before do
        @restaurant = create(:restaurant)
        @plate1 = create(:plate, restaurant: @restaurant)
        @plate2 = create(:plate, restaurant: @restaurant)

        get "/api/v1/plates", params: {restaurant_id: @restaurant.id}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "returns plate list with 2 plates" do
        expect(json.count).to eql(2)
      end

      it "returned Plates have right datas" do
        expect(json[0]).to eql(JSON.parse(@plate1.to_json))
        expect(json[1]).to eql(JSON.parse(@plate2.to_json))
      end
    end
  end  
  
  ########## SHOW ##########
  describe "GET /plates/:id" do
    context "When plate exists" do
      before do
        @restaurant = create(:restaurant)      
        @plate = create(:plate, restaurant: @restaurant)
      end

      it "returns 200" do
        get "/api/v1/plates/#{@plate.id}", params: {}
        expect_status(200)
      end

      it "returned plate with right datas" do
        get "/api/v1/plates/#{@plate.id}", params: {}
        expect(json).to eql(JSON.parse(@plate.to_json))
      end
    end

    context "When plate don't exists" do
      it "returns 404" do
        get "/api/v1/plates/#{FFaker::Lorem.word}", params: {}
        expect_status(404)
      end
    end
  end  
  
  ####### CREATE ##########
  describe "POST /plates" do
    
    context "And with valid params" do
      before do
        @restaurant = create(:restaurant)
        @plate_attributes = attributes_for(:plate, restaurant_id: @restaurant.id)
        post "/api/v1/plates", params: {plate: @plate_attributes}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "plate are created with correct data" do
        @plate_attributes.each do |field|
          expect(plate.first[field.first]).to eql(field.last)
        end
      end

      it "Returned data is correct" do
        @plate_attributes.each do |field|
          expect(json[field.first.to_s]).to eql(field.last)
        end
      end
    end

    context "And with invalid params" do
      before do
        post "/api/v1/plates", params: {plate: {}}
      end

      it "returns 400" do
        expect_status(400)
      end
    end
  end
  
  ######### UPDATE #########
  describe "PUT /plates/:id" do
    

    context "When plate exists" do

      before do
        @restaurant = create(:restaurant)
        @plate = create(:plate, restaurant_id: @restaurant.id)
        @plate_attributes = attributes_for(:plate, id: @plate.id)
        put "/api/v1/plates/#{@plate.id}", params: {plate: @plate_attributes}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "plate are updated with correct data" do
        @plate.reload
        @plate_attributes.each do |field|
          expect(@plate[field.first]).to eql(field.last)
        end
      end

      it "Returned data is correct" do
        @plate_attributes.each do |field|
          expect(json[field.first.to_s]).to eql(field.last)
        end
      end

    end

    context "When plate dont exists" do
      before do
        @plate_attributes = attributes_for(:plate)
      end

      it "returns 404" do
        put "/api/v1/plates/#{FFaker::Lorem.word}", params: {plate: @plate_attributes}
        expect_status(404)
      end
    end
  end  
  
  ######### DELETE ##########
  describe "DELETE /plates/:id" do

    context "When plate exists" do

      before do
        @restaurant = create(:restaurant)
        @plate = create(:plate, restaurant: @restaurant)
        delete "/api/v1/plates/#{@plate.id}", params: {}
      end

      it "returns 200" do
        expect_status(200)
      end

      it "plate are deleted" do
        expect(plate.all.count).to eql(0)
      end
    end

    context "When plate dont exists" do
      it "returns 404" do
        delete "/api/v1/plates/#{FFaker::Lorem.word}", params: {}
        expect_status(404)
      end
    end
  end  
  
  
  
end
