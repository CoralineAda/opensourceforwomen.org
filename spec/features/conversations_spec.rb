require "rails_helper"

describe "User accesses her inbox" do

  before do
    sign_in_user
  end

  it "displays the inbox" do
    visit "/dashboards/1"
    click_link "My Inbox"
    expect(page).to have_content "Conversations"
  end
end

describe "User creates a conversation" do

  let(:recipient) {
    User.create(email: "bonny@idolhands.com", username: "Bonny", password: "foo123456")
  }

  before do
    sign_in_user
  end

  it "creates a message" do
    visit "/dashboards/1"
    click_link "My Inbox"
    click_link "New Conversation"
    fill_in(:message_recipient_username, with: recipient.username)
    fill_in(:message_body, with: "Hi there!")
    click_button "Send"
    expect(recipient.incoming_messages.count).to eq 1
  end

  it "displays the last message from a conversation" do
    Message.create(conversation_id: Conversation.create.id, recipient_id: User.last.id, sender_id: recipient.id, body: "Hi there!")
    visit "/dashboards/1"
    click_link "My Inbox"
    expect(page).to have_content("Hi there!")
  end

  it "allows replies" do
    conversation = Conversation.create
    conversation.participants = [User.first, recipient]
    Message.create(conversation_id: conversation.id, recipient_id: User.first.id, sender_id: recipient.id, body: "Hi there!")
    visit "/dashboards/1"
    click_link "My Inbox"
    click_link "Hi there!"
    click_link "Reply"
    fill_in(:message_body, with: "Hello yourself!")
    click_button "Send"
    expect(page).to have_content("Hello yourself!")
  end

end