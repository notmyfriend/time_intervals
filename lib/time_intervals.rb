# frozen_string_literal: true

def get_intervals(time_intervals)
  raise ArgumentError unless intervals_valid?(time_intervals)

  time_intervals.sort! { |a, b| a[0] <=> b[0] }
  result = []

  time_intervals.each do |interval|
    if result.empty? || result.last[1] < interval[0]
      result.push(interval)
    elsif result.last[1] >= interval[1]
      next
    else
      result.last[1] = interval[1]
    end
  end

  result
end

def intervals_valid?(time_intervals)
  if time_intervals.nil? ||
     time_intervals.any? { |a, b| a > b } ||
     time_intervals.flatten.any? { |time| !time.is_a?(String) || time.match(/^([0-1][0-9]|2[0-3]):([0-5][0-9])$/).nil? }
    return false
  end

  true
end
