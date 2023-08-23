class PhaseChannel < ApplicationCable::Channel
  def subscribed
    stream_from "phase_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
