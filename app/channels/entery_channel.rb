class EnteryChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'entry_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
