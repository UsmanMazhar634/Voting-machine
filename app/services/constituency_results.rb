# frozen_string_literal: true

# Class for fetching results based on constituency
class ConstituencyResults
  def initialize(params)
    @params = params
  end

  def constituency_results
    if @params[:term].nil?
      Constituency.all.page(@params[:page]).per(1)
    else
      Constituency.find(@params[:term].to_i)
    end
  end
end
