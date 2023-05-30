require 'spec_helper'

class FakeJob
  include Sidekiq::RetryCount

  def perform; end
end

describe Sidekiq::RetryCount::Middleware do
  let(:msg) { { 'class' => 'FakeJob' } }
  let(:worker) { FakeJob.new }

  it 'initialize the worker retry_count to 0' do
    described_class.new.call(worker, msg, nil) {}

    expect(worker.retry_count).to eq 0
  end

  it 'increment the worker retry_count by 1' do
    msg['retry_count'] = 4

    described_class.new.call(worker, msg, nil) {}

    expect(worker.retry_count).to eq 5
  end
end
