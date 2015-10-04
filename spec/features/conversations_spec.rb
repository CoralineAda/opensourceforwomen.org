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
    User.create(
      email: "bonny@idolhands.com",
      username: "Bonny",
      password: "foo123456"
    )
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


  context "given a converstaion" do
    let(:conversation) do
      Conversation.create! do |conversation|
        conversation.participants = [User.first, recipient]
      end
    end

    context "and given a message" do
      let!(:message) do
        Message.create!(
          conversation_id: conversation.id,
          recipient_id: User.first.id,
          sender_id: recipient.id,
          body: "Hi there!"
        )
      end

      it "displays the last message from a conversation" do
        visit "/dashboards/1"
        click_link "My Inbox"
        expect(page).to have_content(message.body)
      end

      it "allows replies" do
        visit "/dashboards/1"
        click_link "My Inbox"
        click_link message.body
        fill_in(:message_body, with: "Hello yourself!")
        click_button "Reply"
        expect(page).to have_content("Hello yourself!")
      end
    end
  end

end
