require 'spec_helper'

describe DiscourseApi::API::Posts do
  let (:client) { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#get_post" do
    before do
      stub_get("http://localhost:3000/posts/11.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("post.json"), headers: { content_type: "application/json" })
    end

    it "fetches a post" do
      the_post = client.get_post(11)
      expect(the_post).to be_a Hash
      expect(the_post['id']).to eq(11)
    end
  end

  describe "#wikify_post" do
    before do
      stub_put("http://localhost:3000/posts/9999/wiki?api_key=test_d7fd0429940&api_username=test_user")
    end

    it "fails on unknown post" do
      client.wikify_post(9999)
      expect(a_put("http://localhost:3000/posts/9999/wiki?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end
  end

  describe "#delete_post" do
    before do
      stub_delete("http://localhost:3000/posts/9999.json?api_key=test_d7fd0429940&api_username=test_user")
    end

    it "deletes a post" do
      client.delete_post(9999)
      expect(a_delete("http://localhost:3000/posts/9999.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end
  end

  describe "#post_action_users" do
    before do
      stub_get("http://localhost:3000/post_action_users.json?api_key=test_d7fd0429940&api_username=test_user&id=11&post_action_type_id=2").to_return(body: fixture("post_action_users.json"), headers: { content_type: "application/json" })
    end

    it "fetches post_action_users" do
      post_action_users = client.post_action_users(11, 2)
      expect(post_action_users).to be_a Hash
      expect(post_action_users["post_action_users"][0]["id"]).to eq(1286)
    end
  end

end
