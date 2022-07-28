require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /todos" do
    before { get '/todos'}

    it 'returns todos' do
      expect(json).not_to_be_empty
      expect(json.size).to_eq(10)
    end

    it 'returns status code 200' do
      expect(response).to_have_http_status(200)
    end
  end

  describe "GET /todos/:id" do
    before {get "/todos/#{todo_id}"}

    context 'when the record exists' do
      it 'return the todo' do
        expect(json).not_to_be_empty
        expect(json['id']).to_eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to_have_http_status(200)
      end
    end

    context 'when the record doesn not exist' do
      let(:todo_id) { 100 }

      it 'return statue_code 404' do
        expect(response).to_have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to_match(/Couldn't find Todo/)
      end
    end

end
