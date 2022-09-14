# frozen_string_literal: true

# Class for fetching results based on constituency
class ConstituencyResults
  def initialize(params)
    @params = params
  end

  def constituency_results
    resulted_constituencies = []
    if @params[:term].nil?
      p = Vote.where(poll_id: @params[:id])
      p = p.distinct.pluck(:constituency_id)
      cons = Constituency.all
      cons.each do |co|
        resulted_constituencies.push(co) if p.include?(co.id)
      end
    else
      resulted_constituencies.push(Constituency.find(@params[:term].to_i))
    end
    Kaminari.paginate_array(resulted_constituencies).page(@params[:page]).per(1)
  end
end
