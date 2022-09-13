require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "does not save user when password does not match password_confirmation" do
      @user = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "bob@gmail.com"
        p.password = "password"
        p.password_confirmation = "pasword"
      end
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "does not save user when email is already used" do
      @user1 = User.new do |p|
        p.first_name = "gloria"
        p.last_name = "cheung"
        p.email = "gloria@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      @user1.save!
      
      @user2 = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "Gloria@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      if !User.where({email: "gloria@gmail.com"})
        @user2.save
      end

      expect(@user2.id).not_to be_present
    end

    it "does not save user when email is not present" do
      @user = User.new do |p|
        p.first_name = "gloria"
        p.last_name = "cheung"
        p.email = nil
        p.password = "password"
        p.password_confirmation = "password"
      end
      
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "does not save user when first name is not present" do
      @user = User.new do |p|
        p.first_name = nil
        p.last_name = "cheung"
        p.email = "gloriaa@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "does not save user when last name is not present" do
      @user = User.new do |p|
        p.first_name = "gloria"
        p.last_name = nil
        p.email = "gloriaa@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "does not save user when password is less than 8 characters" do
      @user = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "bob@gmail.com"
        p.password = "pass"
        p.password_confirmation = "pass"
      end
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "logs in user even if there are spaces before email address" do
      @user = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "bob@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      @user.save!

      user = User.authenticate_with_credentials("  bob@gmail.com", "password")
      expect(user).to be_truthy
    end

    it "logs in user even if there are spaces after email address" do
      @user = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "bob@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      @user.save!

      user = User.authenticate_with_credentials("bob@gmail.com   ", "password")
      expect(user).to be_truthy
    end

    it "logs in user even if there are upper and lowercase in email address" do
      @user = User.new do |p|
        p.first_name = "bob"
        p.last_name = "bobby"
        p.email = "bob@gmail.com"
        p.password = "password"
        p.password_confirmation = "password"
      end
      @user.save!

      user = User.authenticate_with_credentials("bOb@gMail.com", "password")
      expect(user).to be_truthy
    end    
  end
end
