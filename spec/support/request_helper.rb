module Requests
  module JsonHelpers
    def expect_status(expectation)
      expect(response.status).to eql(expectation)
    end

    def json
      JSON.parse(response.body)
    end
  end
end