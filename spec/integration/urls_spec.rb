
# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'Urls API' do

  path '/url' do

    post 'Creates a url ' do
      tags 'Urls'
      consumes 'application/json', 'application/xml'
      parameter name: :url, in: :body, schema: {
          type: :object,
          properties: {
              url: { type: :string },
          },
          required: [ 'url']
      }

      response '200', 'url created' do

        schema type: :object,
               properties: {
                   short_url: { type: :string},
                   status: { type: :string },
                   location: { type: :object,
                      properties:{
                          id: { type: :integer, },
                          title: { type: :string, },
                          url: { type: :string, },
                          short_url: { type: :string, },
                          times_accessed: { type: :integer, },
                          created_at: { type: :string, },
                          updated_at: { type: :string, },
                      }
                   },
               }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties:{
                  url: {type: :string}
               }
        run_test!
      end
    end
  end

  path '/api/v1/top' do

    get 'Retrieves most times accessed urls' do
      tags 'Urls'
      produces 'application/json', 'application/xml'
      # parameter name: :id, :in => :path, :type => :string

      response '200', 'Top accessed urls' do
        schema type: :object,
               properties: {
                   id: { type: :integer, },
                   title: { type: :string, },
                   url: { type: :string, },
                   short_url: { type: :string, },
                   times_accessed: { type: :integer, },
                   created_at: { type: :string, },
                   updated_at: { type: :string, },
               }

        # let(:id) { {} }
        run_test!
      end

      response '404', 'Urls not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end