# spec/integration/posts_comments_spec.rb

require 'rails_helper'

RSpec.describe "Posts and Comments", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe "Creating a comment" do
    it "allows a user to create a post and add a comment" do
      # Create a post using the HTTP POST request (use path helpers here)
      post posts_path, params: { post: { name: "Test Post", content: "This is a test post" } }

      # Follow the redirect after creating the post
      follow_redirect!

      # Create a comment for the post
      post post_comments_path(post), params: { comment: { content: "Great post!", rating: 5 } }

      # Follow the redirect after adding the comment
      follow_redirect!

      # Check if the comment is saved successfully
      expect(response).to have_http_status(:ok)
      expect(Comment.last.content).to eq("Great post!")
    end
  end
end
