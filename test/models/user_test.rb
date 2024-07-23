require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    #@user = User.new(name: "name", email:"user@exp.com")
    @user = User.new(name: "name", email:"user@exp.com", password:"passdesu", password_confirmation: "passdesu")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name="  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email="  "
    assert_not @user.valid?
  end

  test "name should not too long" do
    @user.name="a"*51
    assert_not @user.valid?
  end

  test "email should not too long" do
    @user.email="e"*244+"@example.com"
    assert_not @user.valid?
  end

  test "email should accept valid addresses" do
    valid_addresses= %w[user@example.com U.--Ser@Foo.bar.org]
    valid_addresses.each do |valid_adress|
      @user.email=valid_adress
      assert @user.valid?, "#{valid_adress.inspect} shold be valid"
    end
  end
  test "email should reject invalid addresses" do
    invalid_addresses= %w[userexample.com U.--Ser@Foo.bar,org user@ex_sample.com user@ex+sample.com user@bar..com]
    invalid_addresses.each do |invalid_adress|
      @user.email=invalid_adress
      assert_not @user.valid?, "#{invalid_adress.inspect} shold be invalid"
    end
  end

  test "email should be unique" do
    dup_user=@user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password=@user.password_confirmation="  "
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password=@user.password_confirmation="a"*5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

end
