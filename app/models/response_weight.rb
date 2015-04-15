class ResponseWeight < ActiveRecord::Base
  attr_accessible :response1_id, :response2_id, :weight
  def self.find_weight(response1, response2)
    if response1 == response2
        return 0
    end
    query1 = ResponseWeight.where(:response1_id => response1.to_i, :response2_id => response2.to_i)
    query2 = ResponseWeight.where(:response1_id => response2.to_i, :response2_id => response1.to_i)
    if query1.count != 0
        return query1[0].weight
    else
        return query2[0].weight
    end
  end
end