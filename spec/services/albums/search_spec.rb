require 'rails_helper'

RSpec.describe 'Albums Service' do
  describe "Search" do
    it 'search various types through API by artist name' do
      session_token ||= AlbumsService.renew_auth_token[:access_token]
      search_response = AlbumsService.search_by_artist("Led Zeppilin", session_token)

      expect(search_response).to have_key(:albums)
      expect(search_response[:albums]).to have_key(:items)
      expect(search_response.dig(:albums, :items)).to be_a(Array)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:id)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:images)
      expect(search_response.dig(:albums, :items, 0, :images)).to be_a(Array)
      expect(search_response.dig(:albums, :items, 0, :images, 2)).to have_key(:url)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:name)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:release_date)
    end

    it 'finds album by album id' do
      session_token ||= AlbumsService.renew_auth_token[:access_token]
      search_response = AlbumsService.search_by_album_id("4aawyAB9vmqN3uQ7FjRGTy", session_token)

      expect(search_response).to have_key(:id)
      expect(search_response).to have_key(:images)
      expect(search_response[:images]).to be_a(Array)
      expect(search_response.dig(:images, 2)).to have_key(:url)
      expect(search_response).to have_key(:name)
      expect(search_response).to have_key(:release_date)
    end

    it 'search various types through API for suggestions' do
      session_token ||= AlbumsService.renew_auth_token[:access_token]
      search_response = AlbumsService.search_suggested(['classic', 'rock', 'punk'].sample, session_token)

      expect(search_response).to have_key(:tracks)
      expect(search_response[:tracks]).to be_a(Array)
      expect(search_response.dig(:tracks, 0)).to have_key(:album)
      expect(search_response.dig(:tracks, 0, :album)).to have_key(:id)
      expect(search_response.dig(:tracks, 0, :album)).to have_key(:images)
      expect(search_response.dig(:tracks, 0, :album, :images)).to be_a(Array)
      expect(search_response.dig(:tracks, 0, :album, :images, 2)).to have_key(:url)
      expect(search_response.dig(:tracks, 0, :album)).to have_key(:name)
      expect(search_response.dig(:tracks, 0, :album)).to have_key(:release_date)
    end

    it 'search various types through API for recent release' do
      session_token ||= AlbumsService.renew_auth_token[:access_token]
      search_response = AlbumsService.search_recent(session_token)

      expect(search_response).to have_key(:albums)
      expect(search_response[:albums]).to have_key(:items)
      expect(search_response.dig(:albums, :items)).to be_a(Array)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:id)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:images)
      expect(search_response.dig(:albums, :items, 0, :images)).to be_a(Array)
      expect(search_response.dig(:albums, :items, 0, :images, 2)).to have_key(:url)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:name)
      expect(search_response.dig(:albums, :items, 0)).to have_key(:release_date)
    end
  end
end
