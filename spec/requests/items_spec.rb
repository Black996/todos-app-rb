require 'rails_helper'

RSpec.describe "Items", type: :request do
  let!(:todo) { create(:todo)}
  let!(:items) {create_list(:item,10,todo_id:todo.id)}
  let(:todo_id) {todo.id}
  let(:id) {items.first.id}

  describe "GET /todo/:todo_id/items" do
    before { get "/todos/#{todo_id}/items"}

    context 'when todo exists' do
      it 'returns todos' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) {0}

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

  end

  describe "GET /todos/:todo_id/items/:id" do
    before {get "/todos/#{todo_id}/items/#{id}"}

    context 'when item exists' do
      it 'return the item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'return statue code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end


    describe 'POST /todos/:todo_id/items' do
      let(:valid_attributes) {{name:"Learn the Syntax of Ruby", done: true}};

      context 'when the request attributes are valid' do
        before {post "/todos/#{todo_id}/items",params:valid_attributes}

        it 'returns 201 status code' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before {post "/todos/#{todo_id}/items",params: {done:true}}

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed: Name can't be blank/)
        end
      end
    end


    describe 'PUT /todos/:todo_id/items/:id' do
        let(:valid_attributes) {{name:"Learn Ruby on Rails Features"}}
        before {put "/todos/#{todo_id}/items/#{id}", params:valid_attributes}

        context 'when the item exists' do

          it 'updates the item' do
            updated_item =  Item.find(id)
            expect(updated_item.name).to match(/Learn Ruby on Rails Features/)
          end

          it 'response status code 204' do
            expect(response).to have_http_status(204)
          end
        end

        context 'when the item does not exist' do
          let(:id){0}

          it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end

          it 'returns not found message' do
            expect(response.body).to match(/Couldn't find Item/)
        end
      end
    end

      # DELETE

      describe 'DELETE /todos/:todo_id/items/:id' do
          before {delete "/todos/#{todo_id}/items/#{id}"}

          it 'response status code 204' do
            expect(response).to have_http_status(204)
          end
        end
end
