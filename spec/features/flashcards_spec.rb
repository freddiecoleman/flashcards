require 'spec_helper'

describe "Flashcards" do
  describe "GET /flashcards" do
   it "display some flashcards" do
   	visit flashcards_path
   	page.should have_content 'this is a test task'
   end
  end
end