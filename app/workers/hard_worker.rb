class HardWorker
  include Sidekiq::Worker
  def perform
    CounterOrder.create!(notes: "MADE BY SIDEKIQ at #{Time.now}")
  end
end