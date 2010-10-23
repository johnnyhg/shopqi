module MembersHelper
  def current_member_name
    current_member.login.blank? ? current_member.email : current_member.login
  end
end
