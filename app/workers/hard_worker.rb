class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    CounterOrder.create!(notes: "MADE BY SIDEKIQ")
  end
end