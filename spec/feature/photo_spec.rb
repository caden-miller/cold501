# spec/controllers/photos_controller_spec.rb
require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:photo) { create(:photo, user: user) }

  let!(:user) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  before do
    sign_in user # Ensure user is signed in for all tests
  end

  describe 'GET #index' do
    it 'assigns @photos and renders the index template' do
      get :index
      expect(assigns(:photos)).to eq([photo])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested photo and renders the show template' do
      get :show, params: { id: photo.id }
      expect(assigns(:photo)).to eq(photo)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new photo and renders the new template' do
      get :new
      expect(assigns(:photo)).to be_a_new(Photo)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested photo and renders the edit template' do
      get :edit, params: { id: photo.id }
      expect(assigns(:photo)).to eq(photo)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'when params[:photo] is blank' do
      it 'redirects to photos path with a cancellation alert' do
        post :create, params: { photo: nil }
        expect(response).to redirect_to(photos_path)
        expect(flash[:alert]).to eq('Photo creation was canceled.')
      end

      it 'renders a Turbo Stream response with an empty replacement' do
        post :create, params: { photo: nil, format: :turbo_stream }
        expect(response.media_type).to eq Mime[:turbo_stream]
        # Add checks if you render specific content in the Turbo Stream response
      end
    end

    context 'with valid attributes' do
      it 'creates a new photo and redirects to the photos path' do
        post :create, params: { photo: attributes_for(:photo) }
        expect(assigns(:photo)).to be_persisted
        expect(response).to redirect_to(photos_path)
        expect(flash[:notice]).to eq('Photo Created')
      end

      it 'responds to Turbo Stream format' do
        post :create, params: { photo: attributes_for(:photo), format: :turbo_stream }
        expect(response.media_type).to eq Mime[:turbo_stream]
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new photo and re-renders the new template' do
        post :create, params: { photo: attributes_for(:photo, title: nil) }
        expect(assigns(:photo)).to be_a_new(Photo)
        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to be_present
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the requested photo and redirects to photos path' do
        patch :update, params: { id: photo.id, photo: { title: 'Updated Title' } }
        photo.reload
        expect(photo.title).to eq('Updated Title')
        expect(response).to redirect_to(photos_path)
        expect(flash[:notice]).to eq('Photo was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the photo and re-renders the edit template' do
        patch :update, params: { id: photo.id, photo: { title: nil } }
        expect(assigns(:photo).errors).not_to be_empty
        expect(response).to render_template(:edit)
        expect(flash.now[:alert]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the photo and redirects to photos path' do
      photo_to_delete = create(:photo, user: user)
      delete :destroy, params: { id: photo_to_delete.id }
      expect { photo_to_delete.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(photos_path)
      expect(flash[:notice]).to eq('Photo was successfully deleted.')
    end
  end

  describe 'GET #gallery' do
    it 'assigns @photos and renders the gallery template' do
      get :gallery
      expect(assigns(:photos)).to eq([photo])
      expect(response).to render_template(:gallery)
    end
  end
end
