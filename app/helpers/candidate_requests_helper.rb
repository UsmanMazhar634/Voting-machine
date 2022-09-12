# frozen_string_literal: true

module CandidateRequestsHelper
  def requests(requests)
    render partial: 'candidate_requests/show_request', locals: { requests: requests }
  end
end
