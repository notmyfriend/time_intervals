# frozen_string_literal: true

require 'rspec'
require_relative '../lib/time_intervals'

describe '#get_intervals' do
  subject { get_intervals(intervals) }

  it 'processes reqular set of time intervals' do
    intervals = [['10:00', '10:20'], ['10:40', '11:00'], ['10:50', '12:00'], ['12:00', '13:00'], ['10:00', '10:20']]

    expect(get_intervals(intervals)).to eq([['10:00', '10:20'], ['10:40', '13:00']])
  end

  it 'processes set with only one interval' do
    intervals = [['10:00', '10:20']]

    expect(get_intervals(intervals)).to eq([['10:00', '10:20']])
  end

  it 'processes empty set of intervals' do
    intervals = []

    expect(get_intervals(intervals)).to eq([])
  end

  it 'raises exception if set contains invalid intervals' do
    intervals1 = nil
    intervals2 = [['10:00', '10:20'], [10.40, '11:00'], [1_050, '12:00']]
    intervals3 = [['10:00', '10:90'], ['10.40', '30:60'], ['24:50', '12:00']]

    expect { get_intervals(intervals1) }.to raise_error(ArgumentError)
    expect { get_intervals(intervals2) }.to raise_error(ArgumentError)
    expect { get_intervals(intervals3) }.to raise_error(ArgumentError)
  end

  context 'when interval includes a following interval' do
    let(:intervals) do
      [
        ['10:00', '10:20'],
        ['10:30', '15:00'],
        ['10:40', '11:00'],
        ['10:50', '12:00'],
        ['12:00', '13:00'],
        ['10:00', '10:20']
      ]
    end
    let(:expected_result) { [['10:00', '10:20'], ['10:30', '15:00']] }

    it 'returns two intervals' do
      expect(subject).to eq(expected_result)
    end
  end
end
