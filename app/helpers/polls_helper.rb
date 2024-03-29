# frozen_string_literal: true

# Poll Helper
module PollsHelper
  def find_result(cons)
    unless cons.votes.empty?
      res = @votes.where(constituency_id: cons.id)
      res = res.group(:candidate_id).count(:id)
      winner = Candidate.find(res.keys[0])
      win_user = User.find(winner.user_id)
      candidate_request = CandidateRequest.find_by(voter_id: win_user.id)
      render partial: 'polls/show_result',
             locals: { cons: cons, res: res, winner: winner, win_user: win_user,
                       candidate_request: candidate_request }
    end
  end
end
