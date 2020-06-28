class CommentDecorator < ApplicationDecorator
  delegate_all
  def visible?
    is_admin = h.current_user.admin?
    is_organizer = h.currnt_user.organizer_events.include?(proposal.event)
    is_commenter = h.current_user == self.person
    is_admin || is_organizer || is_commenter
  end
end

