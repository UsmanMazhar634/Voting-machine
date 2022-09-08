# frozen_string_literal: true

# Poll Helper
module PollsHelper
  def find_result(cons)
    unless cons.votes.empty?
      res = @votes.where(constituency_id: cons.id)
      res = res.group(:candidate_id).count(:id)
      winner = Candidate.find_by(id: res.keys[0])
      win_user = User.find_by(id: winner.user_id)
      render partial: 'polls/show_result', locals: { cons: cons, res: res, winner: winner, win_user: win_user }
    end
  end
end
