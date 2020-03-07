# frozen_string_literal: true

# == Schema Information
# Table name: alerts
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  user_id        :integer
#  article_id     :integer
#  revision_id    :integer
#  type           :string(255)
#  email_sent_at  :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  message        :text(65535)
#  target_user_id :integer
#  subject_id     :integer
#  resolved       :boolean          default(FALSE)
#  details        :text(65535)
#

# Alert for an instructor marks a particular article as including work
# that requires Wiki Expert intervention
class BadWorkAlert < Alert
  def main_subject
    "#{article.title} — #{course&.slug}"
  end

  def url
    "#{course_url}/articles/edited?showArticle=#{article.id}"
  end

  def resolvable?
    !resolved
  end

  def send_email
    email_content_expert
  end

  def resolve_explanation
    <<~EXPLANATION
      Resolving this alert means the article work in question has been addressed
      with the students, the instructor, or the community.
    EXPLANATION
  end
end