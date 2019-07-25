class Comment < ActiveRecord::Base

  belongs_to :proposal
  belongs_to :person

  validates :proposal, :person, presence: true
  validates :body, presence: true
  after_create :notify_with_slack

  def notify_with_slack
    return unless public?
    notifier = Slack::Notifier.new(Rails.application.config.slack_webhook_url, username: "CFP")
    msg = Slack::Notifier::Util::LinkFormatter.format("Proposal: #{proposal.title} has new comment #{Rails.application.routes.url_helpers.reviewer_event_proposal_url(slug: proposal.event.slug, uuid: proposal.uuid, host: "cfp.iplayground.io")}")
    notifier.ping(msg)
  end

  def public?
    type == "PublicComment"
  end
end


# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  proposal_id :integer
#  person_id   :integer
#  parent_id   :integer
#  body        :text
#  type        :string
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_comments_on_person_id    (person_id)
#  index_comments_on_proposal_id  (proposal_id)
#
